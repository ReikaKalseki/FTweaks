require("config")
require "functions"

data.raw["pipe-to-ground"]["pipe-to-ground"].fast_replaceable_group = "pipe-to-ground"

data.raw["electric-pole"]["small-electric-pole"].fast_replaceable_group = "powerpole"
data.raw["electric-pole"]["medium-electric-pole"].fast_replaceable_group = "powerpole"

if data.raw["electric-pole"]["medium-electric-pole-2"] then
	--data.raw["electric-pole"]["small-electric-pole-2"].fast_replaceable_group = "powerpole"
	data.raw["electric-pole"]["medium-electric-pole-2"].fast_replaceable_group = "powerpole"
end
if data.raw["electric-pole"]["medium-electric-pole-3"] then
	--data.raw["electric-pole"]["small-electric-pole-3"].fast_replaceable_group = "powerpole"
	data.raw["electric-pole"]["medium-electric-pole-3"].fast_replaceable_group = "powerpole"
end
if data.raw["electric-pole"]["medium-electric-pole-4"] then
	--data.raw["electric-pole"]["small-electric-pole-4"].fast_replaceable_group = "powerpole"
	data.raw["electric-pole"]["medium-electric-pole-4"].fast_replaceable_group = "powerpole"
end
if data.raw["electric-pole"]["medium-electric-pole-5"] then
	--data.raw["electric-pole"]["small-electric-pole-5"].fast_replaceable_group = "powerpole"
	data.raw["electric-pole"]["medium-electric-pole-5"].fast_replaceable_group = "powerpole"
end

--data.raw["straight-rail"]["straight-rail"].collision_mask = {--[["item-layer", "object-layer", --]]"floor-layer", --[["water-tile",--]] "not-colliding-with-itself"}
--data.raw["curved-rail"]["curved-rail"].collision_mask = {--[["item-layer", "object-layer", --]]"floor-layer", --[["water-tile",--]] "not-colliding-with-itself"}


data.raw["rail-signal"]["rail-signal"].collision_mask = {--[["item-layer", "object-layer", --]]"floor-layer", --[["water-tile",--]]}
data.raw["rail-chain-signal"]["rail-chain-signal"].collision_mask = {--[["item-layer", "object-layer", --]]"floor-layer", --[["water-tile",--]]}

-- Stack Sizes
if Config.stackSize then
	increaseStackSize("stone", 200)
	increaseStackSize("coal", 200)
	increaseStackSize("iron-ore", 200)
	increaseStackSize("copper-ore", 200)
	increaseStackSize("uranium-ore", 200)
	increaseStackSize("sulfur", 200)
	increaseStackSize("raw-wood", 200)
	
	increaseStackSize("wood", 200)
	increaseStackSize("iron-plate", 200)
	increaseStackSize("copper-plate", 200)
	increaseStackSize("steel-plate", 200)
	increaseStackSize("uranium-238", 200)
	increaseStackSize("uranium-235", 200)

	increaseStackSize("plastic-bar", 200)
	increaseStackSize("stone-brick", 200)
	increaseStackSize("battery", 200)
	increaseStackSize("stone-wall", 100)
	
	increaseStackSize("concrete", 500)
	increaseStackSize("landfill", 500)

	increaseStackSize("rocket-fuel", 50)
	increaseStackSize("low-density-structure", 50)
	
	increaseStackSize("infinity-chest", 1000)
	increaseStackSize("electric-energy-interface", 1000)
end

-- Cheaper Steel
if Config.cheapSteel then
	data.raw.recipe["steel-plate"].normal.energy_required = 7.5
	data.raw.recipe["steel-plate"].normal.ingredients = {{"iron-plate", 2}}
	data.raw.recipe["steel-plate"].expensive.energy_required = 15
	data.raw.recipe["steel-plate"].expensive.ingredients = {{"iron-plate", 4}}
end

if data.raw.ammo["ammo-nano-constructors"] then
	improveAttribute(data.raw.ammo["ammo-nano-constructors"], "magazine_size", 25) --from 10
end

--[[
if Config.coalInSteel then
	table.insert(data.raw.recipe["steel-plate"].normal.ingredients, {"coal", 1}) --requires new input slot
	table.insert(data.raw.recipe["steel-plate"].expensive.ingredients, {"coal", 2})
	data.raw.furnace["stone-furnace"].source_inventory_size = math.max(2, data.raw.furnace["stone-furnace"].source_inventory_size) --does not work, triggers crash
	data.raw.furnace["steel-furnace"].source_inventory_size = math.max(2, data.raw.furnace["steel-furnace"].source_inventory_size)
	data.raw.furnace["electric-furnace"].source_inventory_size = math.max(2, data.raw.furnace["electric-furnace"].source_inventory_size)
end
--]]

if Config.saneConcrete then
	replaceItemInRecipe(data.raw.recipe.concrete, "iron-ore", "iron-stick", 2) --x2 since sticks are 0.5 iron each, this maintains ratios
end

if data.raw.technology["inserter-stack-size-bonus-1"] then
	table.insert(data.raw.technology["stack-inserter"].prerequisites, "inserter-stack-size-bonus-1")
	data.raw.technology["stack-inserter"].effects[3].modifier = 3
end

replaceItemInRecipe(data.raw.recipe["nuclear-reactor"], "concrete", "refined-concrete", 1)
replaceItemInRecipe(data.raw.recipe["centrifuge"], "concrete", "refined-concrete", 1)
replaceItemInRecipe(data.raw.recipe["artillery-turret"], "concrete", "refined-concrete", 1)
replaceItemInRecipe(data.raw.recipe["rocket-silo"], "concrete", "refined-concrete", 1)

if data.raw.item["titanium-plate"] then
	replaceItemInRecipe(data.raw.recipe["refined-concrete"], "steel-plate", "titanium-plate", 0.4)
	removeItemFromRecipe(data.raw.recipe["refined-concrete"], "iron-stick")
	splitTech("concrete", {"titanium-processing"}, {"refined-concrete", "refined-hazard-concrete"})
end

if data.raw["assembling-machine"]["bob-greenhouse"] then --buff Bob Greenhouses to compete with TreeFarm
	data.raw.recipe["bob-basic-greenhouse-cycle"].normal.energy_required = data.raw.recipe["bob-basic-greenhouse-cycle"].normal.energy_required*0.75
	data.raw.recipe["bob-basic-greenhouse-cycle"].expensive.energy_required = data.raw.recipe["bob-basic-greenhouse-cycle"].expensive.energy_required*0.75
	data.raw.recipe["bob-advanced-greenhouse-cycle"].normal.energy_required = data.raw.recipe["bob-advanced-greenhouse-cycle"].normal.energy_required*0.75
	data.raw.recipe["bob-advanced-greenhouse-cycle"].expensive.energy_required = data.raw.recipe["bob-advanced-greenhouse-cycle"].expensive.energy_required*0.75
end

addSciencePackToTech("nickel-processing", "science-pack-2")
addSciencePackToTech("gold-processing", "science-pack-3")
addSciencePackToTech("silver-processing", "science-pack-3")
addSciencePackToTech("zinc-processing", "science-pack-3")
addSciencePackToTech("aluminium-processing", "science-pack-3")
addSciencePackToTech("lithium-processing", "science-pack-3")
addSciencePackToTech("tungsten-processing", "high-tech-science-pack")
addSciencePackToTech("titanium-processing", "production-science-pack")

data:extend({
	createConversionRecipe("burner-mining-drill", "electric-mining-drill"),
	createConversionRecipe("burner-inserter", "inserter"),
})
	createConversionRecipe("steel-furnace", "electric-furnace", true, "advanced-material-processing-2")
createConversionRecipe("stone-furnace", "steel-furnace", true, "advanced-material-processing")

if data.raw.item["basic-circuit-board"] then
	data.raw.recipe["small-lamp"].ingredients = {
      {"basic-circuit-board", 1},
      {"iron-stick", 3},
      {"iron-plate", 1}
    }
	
	data.raw.recipe["rail-signal"].ingredients = {
      {"basic-circuit-board", 1},
      {"iron-plate", 5}
    }
end

if data.raw.recipe["bob-resin-wood"] then
	data.raw.recipe["bob-resin-wood"].ingredients = nil
	data.raw.recipe["bob-resin-wood"].result = nil
	data.raw.recipe["bob-resin-wood"].result_count = nil
	
	data.raw.recipe["bob-resin-wood"].normal = {
		ingredients = {{"raw-wood", 1}},
		result = "resin",
		result_count = 3
	}
	data.raw.recipe["bob-resin-wood"].expensive = {
		ingredients = {{"raw-wood", 2}},
		result = "resin",
		result_count = 3
	}
end

if data.raw.fluid["ferric-chloride"] then
	local pow = data.raw.item["iron-powder"]
	replaceItemInRecipe(data.raw.recipe["ferric-chloride"], "iron-ore", pow and "iron-powder" or "iron-stick", pow and 1 or 2)
end

for name,e in pairs(data.raw["assembling-machine"]) do
	local recipes = false
	for _,cat in pairs(e.crafting_categories) do
		if cat == "crafting" then
			recipes = true
			break
		end
	end
	if recipes then
		log("Added crafting category 'non-manual' to " .. name)
		table.insert(e.crafting_categories, "non-manual-crafting")
	end
end

if Config.gunTurretRecipes then
	local recipe = table.deepcopy(data.raw.recipe["gun-turret"])
	if recipe.energy_required then recipe.energy_required = 0.25*math.floor(4*recipe.energy_required*0.5) end
	if recipe.normal then recipe.normal.energy_required = 0.25*math.floor(4*recipe.normal.energy_required*0.4) end
	if recipe.expensive then recipe.expensive.energy_required = 0.25*math.floor(4*recipe.expensive.energy_required*0.6) end
	recipe.category = "manual-crafting"
	recipe.name = "manual-gun-turret"
	recipe.localised_name = {"recipe-name.manual-gun-turret"}
	data:extend({recipe})
	table.insert(data.raw.technology.turrets.effects, {type = "unlock-recipe", recipe = recipe.name})
	data.raw.recipe["gun-turret"].category = "non-manual-crafting"
	replaceItemInRecipe(data.raw.recipe["gun-turret"], "iron-plate", "iron-plate", 0.8)
	replaceItemInRecipe(data.raw.recipe["gun-turret"], "iron-gear-wheel", "iron-gear-wheel", 0.9)
	replaceItemInRecipe(data.raw.recipe["gun-turret"], "copper-plate", "copper-plate", 0.75)
end

if Config.redScienceRecipes then
	local recipe = table.deepcopy(data.raw.recipe["science-pack-1"])
	if recipe.energy_required then recipe.energy_required = 0.25*math.floor(4*recipe.energy_required*0.3) end
	if recipe.normal then recipe.normal.energy_required = 0.25*math.floor(4*recipe.normal.energy_required*0.2) end
	if recipe.expensive then recipe.expensive.energy_required = 0.25*math.floor(4*recipe.expensive.energy_required*0.5) end
	recipe.category = "manual-crafting"
	recipe.name = "manual-science-pack-1"
	recipe.localised_name = {"recipe-name.manual-science-pack-1"}
	data:extend({recipe})
	--table.insert(data.raw.technology.turrets.effects, {type = "unlock-recipe", recipe = recipe.name})
	data.raw.recipe["science-pack-1"].category = "non-manual-crafting"
	
	 --keep ratios on this; also, since costs are 1, cannot simply multiply -> have to do this:
	 data.raw.recipe["science-pack-1"].result_count = 5
	data.raw.recipe["science-pack-1"].energy_required = data.raw.recipe["science-pack-1"].energy_required*5 --to keep time/output the same
	if data.raw.recipe["science-pack-1"].normal then
		data.raw.recipe["science-pack-1"].normal.energy_required = data.raw.recipe["science-pack-1"].normal.energy_required*5
		data.raw.recipe["science-pack-1"].expensive.energy_required = data.raw.recipe["science-pack-1"].expensive.energy_required*5
	end
	replaceItemInRecipe(data.raw.recipe["science-pack-1"], "iron-gear-wheel", "iron-gear-wheel", 4)
	replaceItemInRecipe(data.raw.recipe["science-pack-1"], "copper-plate", "copper-plate", 4)
end
	
-- fluid color correction
data.raw["fluid"]["heavy-oil"].base_color = {r=0.906, g=0.376, b=0.145}
data.raw["fluid"]["heavy-oil"].flow_color = {r=1, g=0.635, b=0.267}

data.raw["fluid"]["petroleum-gas"].base_color = {r=0.741, g=0.741, b=0.741}
data.raw["fluid"]["petroleum-gas"].flow_color = {r=0.282, g=0.282, b=0.282}

data.raw["fluid"]["sulfuric-acid"].base_color = {r=0, g=0.7, b=0.788}

data.raw["fluid"]["crude-oil"].base_color = {r=0.25, g=0.25, b=0.25}
data.raw["fluid"]["crude-oil"].flow_color = {r=0.125, g=0.125, b=0.125}

--table.insert(data.raw["heat-pipe"]["heat-pipe"].flags, "placeable-off-grid")
--table.insert(data.raw["heat-pipe"]["heat-pipe"].flags, "not-on-map")
--data.raw["heat-pipe"]["heat-pipe"].collision_mask = {} --makes heat pipes placeable on top of each other

if data.raw["technology"]["fast-loader"] then
	table.insert(data.raw["technology"]["fast-loader"].prerequisites,"loader")
	table.insert(data.raw["technology"]["express-loader"].prerequisites,"fast-loader")
	if data.raw["technology"]["green-loader"] then
		table.insert(data.raw["technology"]["purple-loader"].prerequisites,"express-loader")
		table.insert(data.raw["technology"]["green-loader"].prerequisites,"purple-loader")
	end
	data.raw["technology"]["loader"].prerequisites = {"railway", "logistics-2"}
end

--[[
for name,loader in pairs(data.raw.loader) do --crashes with more than 9 filters
	loader.filter_count = 1+4*(loader.speed/0.03125-1)
	log("Giving loader " .. name .. " " .. loader.filter_count .. " filter slots.")
end
--]]

if data.raw["technology"]["angels-warehouses"] then
	table.insert(data.raw["technology"]["angels-warehouses"].prerequisites, "logistics-2")
end

data.raw["technology"]["flying"].prerequisites = {"engine", "advanced-electronics", "advanced-material-processing"}

local flag = true
for _,prereq in pairs(data.raw["technology"]["power-armor"].prerequisites) do
	if prereq == "military-3" then
		flag = false
	end
end
if flag then
	table.insert(data.raw["technology"]["power-armor"].prerequisites, "military-3")
end

table.insert(data.raw["technology"]["logistic-robotics"].prerequisites, "logistics-3")
if data.raw.tool["logistic-science-pack"] then
	addSciencePackToTech("logistic-robotics", "logistic-science-pack")
end

moveRecipe("poison-capsule", "military-3", "military-2") --why was this even mil3

if Config.harderNuclear then
	data.raw["technology"]["nuclear-power"].prerequisites = {"advanced-electronics-2", "concrete", "advanced-material-processing-2", "electric-energy-distribution-2", "circuit-network", "robotics"}
	table.insert(data.raw["technology"]["nuclear-power"].unit.ingredients, {"high-tech-science-pack", 1})
	table.insert(data.raw["technology"]["nuclear-power"].unit.ingredients, {"production-science-pack", 1})
	
	data.raw["assembling-machine"]["centrifuge"].energy_usage = "600kW" --default is 350
	data.raw["assembling-machine"]["centrifuge"].energy_source.emissions = 0.03 / 2.5 --default is 0.04 / 2.5
end

table.insert(data.raw["technology"]["electric-energy-distribution-2"].prerequisites,"advanced-electronics")

data.raw.item["rocket-silo"].subgroup = "production-machine"

table.insert(data.raw.player["player"].crafting_categories,"manual-crafting")

if Config.tieredArmor then
	data.raw.recipe["heavy-armor"].ingredients = {{"copper-plate", 100}, {"steel-plate", 30}, {"light-armor", 1}}
	data.raw.recipe["modular-armor"].ingredients = {{"heavy-armor", 1}, {"advanced-circuit", 30}}
	data.raw.recipe["power-armor"].ingredients = {{"modular-armor", 1}, {"electric-engine-unit", 20}, {"steel-plate", 20}}
	table.insert(data.raw.recipe["power-armor-mk2"].ingredients, {"power-armor", 1})
end

improveAttribute(data.raw.gun["rocket-launcher"].attack_parameters, "range", 35)--from 22; compare with poison capsule at 25 and T2 flamethrower at 30

-- tougher endgame
if Config.harderSilo then
	data.raw["technology"]["rocket-silo"].unit.count = data.raw["technology"]["rocket-silo"].unit.count*10
	table.insert(data.raw["technology"]["rocket-silo"].prerequisites,"military-4")
	
	if data.raw["technology"]["bob-solar-energy-4"] and not listHasValue(data.raw["technology"]["rocket-silo"].prerequisites, "bob-solar-energy-4") then
		table.insert(data.raw["technology"]["rocket-silo"].prerequisites, "bob-solar-energy-4")
	end
	if data.raw["technology"]["bob-electric-energy-accumulators-4"] and not listHasValue(data.raw["technology"]["rocket-silo"].prerequisites, "bob-electric-energy-accumulators-4") then
		table.insert(data.raw["technology"]["rocket-silo"].prerequisites, "bob-electric-energy-accumulators-4")
	end

	if data.raw["technology"]["speed-module-5"] then
		table.insert(data.raw["technology"]["rocket-silo"].prerequisites, "speed-module-5")
	end
	if data.raw["technology"]["productivity-module-5"] then
		table.insert(data.raw["technology"]["rocket-silo"].prerequisites, "productivity-module-5")
	end
	if data.raw["technology"]["effectivity-module-5"] then
		table.insert(data.raw["technology"]["rocket-silo"].prerequisites, "effectivity-module-5")
	end
	--[[
	if data.raw["technology"]["plasma-turret-9"] then
		table.insert(data.raw["technology"]["rocket-silo"].prerequisites,"plasma-turret-damage-9") --not 10, as that requires space science
	end
	--]]
	--[[
	if data.raw["technology"]["follower-robot-count-20"] then
		table.insert(data.raw["technology"]["rocket-silo"].prerequisites,"follower-robot-count-20")
	end
	--]]

	data.raw["recipe"]["satellite"].energy_required = 600
	data.raw["recipe"]["satellite"].category = "advanced-crafting"
	data.raw["recipe"]["rocket-part"].energy_required = 120
	
	if Config.manualSilo then
		data.raw["recipe"]["rocket-silo"].category = "manual-crafting"
	end
	
	local satparts = {}
	local circuitcount = 0
	for k,item in pairs(data.raw.recipe["satellite"].ingredients) do
		if item[1] == "accumulator" and data.raw.item["large-accumulator-3"] then
			item[1] = "large-accumulator-3"
		end
		if item[1] == "solar-panel" and data.raw.item["solar-panel-5"] then
			item[1] = "solar-panel-5"
		end
		if item[1] == "solar-panel" and data.raw.item["solar-panel-3"] then
			item[1] = "solar-panel-3"
		end
		if item[1] == "processing-unit" then
			circuitcount = item[2]
		end
		log("Adding satellite ingredient: " .. (item[1] and item[1] or "nil") .. " x " .. (item[2] and item[2] or "nil"))
		table.insert(satparts, item)
	end
	if data.raw.item["advanced-processing-unit"] and circuitcount > 0 then
		table.insert(satparts, {"advanced-processing-unit", math.floor(circuitcount/2)})
	end
	if data.raw.item["plutonium"] then --RTG
		table.insert(satparts, {"plutonium", 2})
		table.insert(data.raw.technology["rocket-silo"].prerequisites, "kovarex-enrichment-process")
	end
	
	data.raw["recipe"]["satellite"].ingredients = satparts
	for i = 8,3,-1 do
		if data.raw["assembling-machine"]["assembling-machine-" .. i] then
			data.raw["assembling-machine"]["assembling-machine-" .. i].ingredient_count = math.max(data.raw["assembling-machine"]["assembling-machine-" .. i].ingredient_count, #satparts) --ensure craftability in the highest assembling machine tier
			break
		end
	end
	
	if data.raw.item["titanium-plate"] then
		if data.raw["recipe"]["low-density-structure"].ingredients then
			table.insert(data.raw["recipe"]["low-density-structure"].ingredients, {"titanium-plate", 5})
		else
			table.insert(data.raw["recipe"]["low-density-structure"].normal.ingredients, {"titanium-plate", 5})
			table.insert(data.raw["recipe"]["low-density-structure"].expensive.ingredients, {"titanium-plate", 10})
		end
	end
	if data.raw.item["copper-tungsten-alloy"] then
		if data.raw["recipe"]["low-density-structure"].ingredients then
			for _,ingredient in pairs(data.raw["recipe"]["low-density-structure"].ingredients) do
				if ingredient[1] == "copper-plate" then
					ingredient[1] = "copper-tungsten-alloy"
				end
			end
		else
			for _,ingredient in pairs(data.raw["recipe"]["low-density-structure"].normal.ingredients) do
				if ingredient[1] == "copper-plate" then
					ingredient[1] = "copper-tungsten-alloy"
				end
			end
			for _,ingredient in pairs(data.raw["recipe"]["low-density-structure"].expensive.ingredients) do
				if ingredient[1] == "copper-plate" then
					ingredient[1] = "copper-tungsten-alloy"
				end
			end
		end
	end
	
	local controlparts = {}
	
	for k,item in pairs(data.raw.recipe["rocket-control-unit"].ingredients) do
		if item[1] == "speed-module" then
			if data.raw.module["speed-module-5"] then
				item[1] = "speed-module-5"
			else
				item[1] = "speed-module-3"
			end
		end
		table.insert(controlparts, item)
	end
	data.raw["recipe"]["rocket-control-unit"].ingredients = controlparts
	
	data.raw["recipe"]["rocket-control-unit"].energy_required = data.raw["recipe"]["rocket-control-unit"].energy_required*10
	data.raw["recipe"]["low-density-structure"].normal.energy_required = data.raw["recipe"]["low-density-structure"].normal.energy_required*4
	data.raw["recipe"]["low-density-structure"].expensive.energy_required = data.raw["recipe"]["low-density-structure"].expensive.energy_required*4
	data.raw["recipe"]["rocket-fuel"].energy_required = data.raw["recipe"]["rocket-fuel"].energy_required*5
	table.insert(data.raw["recipe"]["rocket-fuel"].ingredients, {"steel-plate", 2})
	
	if data.raw.fluid["hydrazine"] then
		if not data.raw.technology["rocket-fuel"] then --Bob's is good enough
			table.insert(data.raw["recipe"]["rocket-fuel"].ingredients, {type="fluid", name = "hydrazine", amount = 100})
		end
	elseif data.raw.fluid["hydrogen"] then
		table.insert(data.raw["recipe"]["rocket-fuel"].ingredients, {type="fluid", name = "hydrogen", amount = 200})
		table.insert(data.raw["recipe"]["rocket-fuel"].ingredients, {type="fluid", name = "nitrogen", amount = 100})
		data.raw["recipe"]["rocket-fuel"].category = "chemistry" --to allow 2 fluid inputs
	end
end

data.raw.item["rocket-fuel"].fuel_value = "1000MJ"

if data.raw["technology"]["uranium-processing"] then
	if data.raw["technology"]["advanced-material-processing-4"] then
		table.insert(data.raw["technology"]["uranium-processing"].prerequisites,"advanced-material-processing-4")
	else
		table.insert(data.raw["technology"]["uranium-processing"].prerequisites,"advanced-material-processing-2")
		table.insert(data.raw["technology"]["uranium-processing"].prerequisites,"plastics")
		table.insert(data.raw["technology"]["uranium-processing"].prerequisites,"advanced-oil-processing")
	end
end

if data.raw["underground-belt"]["turbo-underground-belt"] then
	improveAttribute(data.raw["underground-belt"]["turbo-underground-belt"], "max_distance", 30)
	improveAttribute(data.raw["underground-belt"]["turbo-underground-belt"], "speed", 0.15)
	improveAttribute(data.raw["transport-belt"]["turbo-transport-belt"], "speed", 0.15)
	
	if data.raw.loader["purple-loader"] then --they got swapped by Bob
		improveAttribute(data.raw.loader["purple-loader"], "speed", 0.15)
	end
end

if data.raw["underground-belt"]["ultimate-underground-belt"] then
	improveAttribute(data.raw["underground-belt"]["ultimate-underground-belt"], "max_distance", 40)
	improveAttribute(data.raw["underground-belt"]["ultimate-underground-belt"], "speed", 0.2)
	improveAttribute(data.raw["transport-belt"]["ultimate-transport-belt"], "speed", 0.2)
	
	if data.raw.loader["green-loader"] then
		improveAttribute(data.raw.loader["green-loader"], "speed", 0.2)
	end
end

--[[
if data.raw["pipe"]["stone-pipe"] then
	improveAttribute(data.raw["pipe"]["stone-pipe"].fluid_box, "base_area", 4)
end
if data.raw["pipe-to-ground"]["stone-pipe-to-ground"] then
	improveAttribute(data.raw["pipe-to-ground"]["stone-pipe-to-ground"].fluid_box, "base_area", 4)
end
--]]

improveAttribute(data.raw["assembling-machine"]["assembling-machine-3"], "crafting_speed", 1.5) --vanilla is 1.25, which is LESS than a tier2 with the four speed modules

if not mods["bobwarfare"] then
	replaceItemInRecipe(data.raw.recipe["solar-panel-equipment"], "solar-panel", "solar-panel", 0.4) --from 5 to 2
end

--quickfix for getting fluids out of pipes; comment back out when done
--[[
for name,pipe in pairs(data.raw.pipe) do
	pipe.fluid_box.base_level = 4
end
for name,pipe in pairs(data.raw["pipe-to-ground"]) do
	pipe.fluid_box.base_level = 4
end
--]]

--[[
if data.raw["boiler"]["boiler-2"] then
	improveAttribute(data.raw["boiler"]["boiler-2"].fluid_box, "base_area", 2)
	improveAttribute(data.raw["boiler"]["boiler-3"].fluid_box, "base_area", 4)
	improveAttribute(data.raw["boiler"]["boiler-4"].fluid_box, "base_area", 8)
end
--]]

if data.raw.fluid["nitric-oxide"] then
	data:extend({
	  {
		type = "recipe",
		name = "nitric-oxide-decomposition",
		category = "chemistry",
		--order = "f[plastic-bar]-f[venting]",
		icon = data.raw.fluid["nitric-oxide"].icon,
		icon_size = 32,
		energy_required = 0.8,
		enabled = "false",
		subgroup = "bob-fluid",
		ingredients = {
		  {type="fluid", name="nitric-oxide", amount=20},
		  {type="fluid", name="hydrogen", amount=20},
		},
		results = {
		  {type="fluid", name="water", amount=20},
		  {type="fluid", name="nitrogen", amount=10},
		},
	  },
	})
	table.insert(data.raw.technology["nitrogen-processing"].effects, {type = "unlock-recipe", recipe = "nitric-oxide-decomposition"})
end

if data.raw.locomotive["bob-diesel-locomotive-3"] then
	improveAttribute(data.raw.locomotive["bob-diesel-locomotive-3"], "max_speed", 3)
end

if data.raw.recipe["basic-circuit-board"] then
	data.raw.recipe["basic-circuit-board"].energy_required = 0.5
end

if data.raw.recipe["solder"] then
	data.raw.recipe["solder"].energy_required = 0.5
end

if data.raw.tile["frozen-snow-0"] then
	for i = 0,9 do
		local name = "frozen-snow-" .. i
		local tile = data.raw.tile[name]
		if tile then
			tile.walking_speed_modifier = math.sqrt(tile.walking_speed_modifier)
		end
	end
end

local function createSpawnerResistance(spawner)
	local ret = {
	  {
        type = "physical",
        decrease = 3, --was 2
        percent = 25, --was 15
      },
      {
        type = "explosion",
        decrease = 0, --was 5
        percent = math.max(-400, -50*(1+0.2*(math.max(0, (spawner.max_health/350)-1)))), --was +15
      },
      {
        type = "fire",
        decrease = 0, --was 3
        percent = 30, --was 60
      }
	}
	return ret
end

for name,spawner in pairs(data.raw["unit-spawner"]) do
	if name ~= "biter-hive" then --Hives mod
		spawner.resistances = createSpawnerResistance(spawner)
	end
end

for name,worm in pairs(data.raw.turret) do
	if string.find(name, "worm") then
		if worm.resistances then
			local resist = {}
			for _,r in pairs(worm.resistances) do
				if r.type == "poison" then
				
				else
					table.insert(resist, r)
				end
			end
			worm.resistances = resist
		end
	end
end

data.raw.unit["medium-biter"].attack_parameters.range = 0.9 --was 1.0, allowing through-wall attacks

if data.raw["electric-energy-interface"]["wind-turbine-2"] then
	--data.raw["electric-energy-interface"]["wind-turbine-2"].energy_required_source.output_flow_limit = 4--was 1.5
	data.raw.recipe["wind-turbine-2"].ingredients =
    {
      {"iron-plate", 1},
      {"iron-gear-wheel", 2},
      {"copper-cable", 3},
      {"iron-stick", 3}
    }
end

for name,radar in pairs(data.raw.radar) do --by default radar amplification adds 2 "active scan" and 3 "region scan" per level; this changes it to 0.25/5, so that one radar cannot active scan a huge area, and compensates by increasing search range
	if string.find(name, "big_brother", 1, true) then
		local amp = (radar.max_distance_of_sector_revealed-data.raw.radar.radar.max_distance_of_sector_revealed)/3
		if amp > 0 then
			radar.max_distance_of_nearby_sector_revealed = data.raw.radar.radar.max_distance_of_nearby_sector_revealed+math.floor(amp/4)
			radar.max_distance_of_sector_revealed = radar.max_distance_of_sector_revealed+amp*2
		end
	end
end

for name,belt in pairs(data.raw["underground-belt"]) do
	if string.find(name, "subterranean", 1, true) then
		belt.max_distance = 45 --250 is stupidly overpowered
	end
end

for name,pipe in pairs(data.raw["pipe-to-ground"]) do
	if string.find(name, "subterranean", 1, true) then
		pipe.max_distance = 45 --250 is stupidly overpowered
	end
end

for _,robot in pairs(data.raw["construction-robot"]) do
	if robot.resistances == nil then robot.resistances = {} end
	table.insert(robot.resistances, { type = "fire", percent = 100 })
end

data.raw.generator["steam-turbine"].working_sound.sound.filename = "__FTweaks__/sounds/turbine.ogg"
data.raw.generator["steam-turbine"].working_sound.sound.volume = 1.0
data.raw.generator["steam-turbine"].working_sound.match_speed_to_activity = false

data.raw["assembling-machine"]["centrifuge"].working_sound.sound = {
        {
          filename = "__FTweaks__/sounds/centrifuge.ogg",
          volume = 0.8
        },
}

data.raw["accumulator"]["accumulator"]["working_sound"]["sound"][1] = {
        filename = "__base__/sound/accumulator-working.ogg",
        volume = 0.4
}

local function createWaterSounds()
	local ret = {}
	for i = 1,9 do
		ret[#ret+1] = {filename = "__FTweaks__/sounds/walking/water" .. i .. ".ogg", volume=0.85}
	end
	return ret
end

for name,tile in pairs(data.raw.tile) do
	if string.find(name, "water") then
		tile.walking_sound = createWaterSounds()
	end
end

if Config.smallerTrees then
	local f = 0.5
	for name,tree in pairs(data.raw.tree) do
		if tree.selection_box then
			tree.selection_box = {{tree.selection_box[1][1]*f, tree.selection_box[1][2]*f}, {tree.selection_box[2][1]*f, tree.selection_box[2][2]*f}}
		end
	end
end

if data.raw.recipe["breeder-fuel-cell"] then
	table.insert(data.raw.technology["kovarex-enrichment-process"].effects, {type = "unlock-recipe", recipe = "kovarex-enrichment-process"})
end

local f = 1.6
if data.raw.car["heli-entity-_-"] then
	for name,car in pairs(data.raw.car) do
		if string.find(name, "heli", 1, true) then
			--error(serpent.block(car.consumption .. " >> " .. string.sub(car.consumption, 1, -3) .. " >>> " .. tonumber(string.sub(car.consumption, 1, -3))))
			if car.guns and #car.guns > 0 then --skip technical entities
				table.insert(car.guns, "flamethrower-2")
			end
		end
	end
end

data.raw.ammo["flamethrower-ammo"].ammo_type[2].action = data.raw.ammo["flamethrower-ammo"].ammo_type[1].action --because it was nerfed to garbage
data.raw.ammo["flamethrower-ammo"].ammo_type[2].consumption_modifier = 1.25 --as a slight rebalance

if data.raw.technology["worker-robot-battery-1"] then
	data.raw.technology["worker-robot-battery-4"].effects[1].modifier = 0.125
	data.raw.technology["worker-robot-battery-8"].effects[1].modifier = 0.2
	data.raw.technology["worker-robot-battery-12"].effects[1].modifier = 0.25
end

if data.raw.recipe["iron-chunk-processing"] then
	data.raw.recipe["iron-chunk-processing"].allow_decomposition = false
	data.raw.recipe["copper-chunk-processing"].allow_decomposition = false
	data.raw.recipe["coal-chunk-processing"].allow_decomposition = false
	data.raw.recipe["uranium-chunk-processing"].allow_decomposition = false
	--data.raw.recipe["gold-chunk-processing"].allow_decomposition = false
	--data.raw.recipe["silver-chunk-processing"].allow_decomposition = false
	--data.raw.recipe["nickel-chunk-processing"].allow_decomposition = false
	data.raw.recipe["iron-chunk-processing"].allow_as_intermediate = false
	data.raw.recipe["copper-chunk-processing"].allow_as_intermediate = false
	data.raw.recipe["coal-chunk-processing"].allow_as_intermediate = false
	data.raw.recipe["uranium-chunk-processing"].allow_as_intermediate = false
end

if data.raw.lamp["LargeLamp"] then
	data.raw.recipe.LargeLamp.ingredients =
	{
		{"electronic-circuit", 6},
		{"iron-stick", 12},
		{"steel-plate", 4},
	}
	
	if data.raw.item["insulated-cable"] then
		table.insert(data.raw.recipe.LargeLamp.ingredients, {"insulated-cable", 9})
	end
	
	data.raw.lamp.LargeLamp.energy_usage_per_tick = "36kW"
	data.raw.lamp.LargeLamp.light.size = 96
	data.raw.lamp.LargeLamp.light.intensity = 1
	data.raw.lamp.LargeLamp.light_when_colored.size = 90
	data.raw.lamp.LargeLamp.picture_on.filename = "__FTweaks__/graphics/large-lamp-on.png"
end

if Config.expiringFluid then
	for _,fluid in pairs(data.raw.resource) do
		if fluid.category == "basic-fluid" or fluid.category == "water" then
			fluid.infinite = false
		end
	end
end