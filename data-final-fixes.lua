require("prototypes.bridges")
require "functions"

for name, spill in pairs(data.raw["simple-entity"]) do
	if string.find(name, "chemical-spill", 1, true) then
		spill.collision_mask = {}
	end
end


if data.raw["transport-belt"]["wooden-belt"] then
	data:extend({createConversionRecipe("wooden-belt", "transport-belt")})
end

--[[
for _,tech in pairs(data.raw.technology) do
	local packs = tech.unit.ingredients
	local li = {}
	for _,entry in pairs(packs) do
		if entry[2] > 1 then
			table.insert(li, entry[1])
		end
	end
	if #li > 0 then
		log("Technology '" .. tech.name .. "' has non-unity science pack per-cycle costs: " .. serpent.block(li) .. "; vanilla techs were changed to use one pack per cycle per type in 0.15; this may be an oversight in the mod registering this tech.")
	end
end
--]]

local demultiply = {
	["automation"] = 1,
	["logistics"] = 0.5,
	["automation-2"] = 2,
	["logistics-2"] = 4,
	["turrets"] = 2,
	["optics"] = 2,
	["stone-walls"] = 4,
	["gates"] = 2,
	["toolbelt"] = 2,
	["bob-greenhouse"] = 1,
	["long-inserters-1"] = 0.5,
	["long-reach-research_long-reach-1"] = 2,
	["long-reach-research_long-build-1"] = 2,
	["long-mine-research_long-mine-1"] = 2,
	["subterranean-logistics-1"] = 5,
	["turret-monitoring"] = 2,
	["heli-technology"] = 2,
}

local upgradeBlacklist = {
	"stack-inserter",
	"construction-robotics",
	"gas-canisters",
	"electric-boiler",
}

local function isUpgrade(tech)
	if listHasValue(upgradeBlacklist, tech.name) then return false end
	local allRecipes = true
	if tech.effects then
		for _,effect in pairs(tech.effects) do
			if effect.modifier then --a modifier on the tech
				return true
			end
			if effect.type == "nothing" then --custom mod stuff
				return true
			end
			if effect.type ~= "unlock-recipe" then
				allRecipes = false
			end
		end
	else
		allRecipes = false
	end
	if allRecipes then
		return false
	end
	if string.find(tech.name, "-1", 1, true) then
		return false
	end
	if tech.upgrade then
		return true
	end
	return false
end

if Config.techFactor ~= 1 then

	local adjusted = {}

	if Config.demultiplyUpgrades then
		for name,tech in pairs(data.raw.technology) do
			if isUpgrade(tech) then
				log("Marked tech " .. name .. " as an upgrade; restoring 1x cost")
				reduceTechnologyCost(tech, 1)
				table.insert(adjusted, name)
			end
		end
	end

	for tech,amt in pairs(demultiply) do
		if data.raw.technology[tech] and (not listHasValue(adjusted, tech)) then
			reduceTechnologyCost(tech, amt)
		end
	end
	
	for i = 1,8 do
		local tech = data.raw.technology["inserter-capacity-bonus-" .. i]
		if tech and (not listHasValue(adjusted, tech.name)) then
			if tech.unit.count then
				reduceTechnologyCost(tech, 1+(i-1)/2)
			elseif tech.unit.count_formula then
				tech.unit.count_formula = "2^(L-8)*500"
			end
		end
	end
	
	if data.raw.technology["turret-range-1"] then
		for i = 1,10 do
			local id = "turret-range-" .. i
			if not listHasValue(adjusted, id) then
				local f1 = 2*i/2
				local f2 = f1-1
				local f = 1+(Config.techFactor-1)*(1-f2/f1)
				local amt = data.raw.technology[id].unit.count/f
				amt = sigFig(amt, 2)
				--log(i .. " => " .. f .. " so " .. data.raw.technology["turret-range-" .. i].unit.count .. " => " .. amt)
				data.raw.technology["turret-range-" .. i].unit.count = amt
			end
		end
	end
end

data.raw.recipe["kovarex-enrichment-process"].energy_required = 0.0012