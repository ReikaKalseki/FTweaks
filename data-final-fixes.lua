require("prototypes.bridges")

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