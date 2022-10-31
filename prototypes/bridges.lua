require "functions"
require "config"

require "__DragonIndustries__.entities"

local function createVoidRecipe(fluid)
	if data.raw.fluid[fluid] and data.raw.recipe["void-hydrogen"] then
		local rec = table.deepcopy(data.raw.recipe["void-hydrogen"])
		
		rec.name = "void-" .. fluid
		rec.ingredients[1].name = fluid
		rec.icon = "__bobplates__/graphics/icons/void.png"
		if data.raw.fluid.icon then
			rec.icon = nil
			rec.icons = {{icon="__bobplates__/graphics/icons/void.png"}, {icon=data.raw.fluid.icon}}
		end
		if data.raw.fluid.icons then
			rec.icon = nil
			local top = data.raw.fluid.icons[#data.raw.fluid.icons]
			rec.icons = {{icon="__bobplates__/graphics/icons/void.png"}, {icon=top}}
		end
		rec.order = fluid
		
		data:extend({
			rec
		})
	end
end

createVoidRecipe("water")
createVoidRecipe("pure-water")
createVoidRecipe("steam")
createVoidRecipe("air")
createVoidRecipe("liquid-air")

if data.raw.recipe["large-accumulator"] then
	log(tostring(Config.harderSilo))
		if not Config.harderSilo then
			local ingredients = nil
			local exp = nil
			local norm = nil
			local accucount = 0
			if data.raw.recipe["satellite"].ingredients then
				ingredients = {}
				for k,item in pairs(data.raw.recipe["satellite"].ingredients) do
					if item[1] == "accumulator" then
						accucount = item[2]
					else
						table.insert(ingredients, item)
					end
				end
				table.insert(ingredients, {"large-accumulator", math.floor(accucount*0.8)})
			end
			if data.raw.recipe["satellite"].normal then
				norm = {}
				for k,item in pairs(data.raw.recipe["satellite"].normal.ingredients) do
					if item[1] == "accumulator" then
						accucount = item[2]
					else
						table.insert(norm, item)
					end
				end
				table.insert(norm, {"large-accumulator", math.floor(accucount*0.8)})
			end
			if data.raw.recipe["satellite"].expensive then
				exp = {}
				for k,item in pairs(data.raw.recipe["satellite"].expensive.ingredients) do
					if item[1] == "accumulator" then
						accucount = item[2]
					else
						table.insert(exp, item)
					end
				end
				table.insert(exp, {"large-accumulator", math.floor(accucount*0.8)})
			end
		end
	
	local rec = createConversionRecipe("accumulator", "large-accumulator", true, "bob-electric-energy-accumulators-2")
	local rec = createConversionRecipe("accumulator", "fast-accumulator", true, "bob-electric-energy-accumulators-2")

	if not Config.harderSilo then
		data:extend(
		{
		  {
			type = "recipe",
			name = "large-accumulator-satellite",
			energy_required = data.raw.recipe["satellite"].energy_required,
			enabled = "true",
			ingredients = ingredients,
			result = "satellite",
			expensive = exp and {
				ingredients = exp,
				energy_required = data.raw.recipe["satellite"].energy_required,
				result = "satellite",
			} or nil,
			normal = norm and {
				ingredients = norm,
				energy_required = data.raw.recipe["satellite"].energy_required,
				result = "satellite",
			} or nil,
		  }
		})
	end
	 
	--table.insert(data.raw.technology["bob-electric-energy-accumulators-2"].effects, {type = "unlock-recipe", recipe = rec.name})
	 
	if not Config.harderSilo then
		table.insert(data.raw.technology["rocket-silo"].effects, {type = "unlock-recipe", recipe = "large-accumulator-satellite"})
	end
end

if data.raw.recipe["chemical-furnace"] then

	--[[
	data:extend(
	{
	  {
		type = "recipe",
		name = "chemical-furnace-conversion",
		energy = 8,
		enabled = "false",
		ingredients =
		{
		  {"electric-furnace", 1},
		  {"steel-pipe", 5},
		},
		result = "chemical-furnace"
	  }
	})
	--]]
	
	local rec = createConversionRecipe("electric-furnace", "chemical-furnace", true, "chemical-processing-3")
	 
	--table.insert(data.raw.technology["chemical-processing-3"].effects, {type = "unlock-recipe", recipe = rec.name})
end

if data.raw.recipe["electric-chemical-mixing-furnace"] then

	--[[
	data:extend(
	{
	  {
		type = "recipe",
		name = "chemical-furnace-conversion-2",
		energy = 8,
		enabled = "false",
		ingredients =
		{
		  {"electric-furnace-2", 1},
		  {"tungsten-gear-wheel", 10},
		  {"processing-unit", 5},
		},
		result = "electric-chemical-mixing-furnace"
	  },
	  {
		type = "recipe",
		name = "chemical-furnace-conversion-3",
		energy = 8,
		enabled = "false",
		ingredients =
		{
		  {"electric-furnace-3", 1},
		  {"tungsten-pipe", 10},
		  {"tungsten-gear-wheel", 10},
		  {"advanced-processing-unit", 5},
		  {"processing-unit", 5},
		},
		result = "electric-chemical-mixing-furnace-2"
	  },	  
	})
	--]]
	
	
	local rec1 = createConversionRecipe("electric-furnace-2", "electric-chemical-mixing-furnace", true, "multi-purpose-furnace-1")
	local rec2 = createConversionRecipe("electric-furnace-3", "electric-chemical-mixing-furnace-2", true, "multi-purpose-furnace-2")
	 
	--table.insert(data.raw.technology["chemical-processing-3"].effects, {type = "unlock-recipe", recipe = rec1.name})
	--table.insert(data.raw.technology["chemical-processing-3"].effects, {type = "unlock-recipe", recipe = rec2.name})
end

--[[
if data.raw.technology["subterranean-logistics-1"] then
		data:extend(
	{
	  {
		type = "recipe",
		name = "subterranean-belt-conversion-1",
		energy = 0.5,
		enabled = "false",
		ingredients =
		{
		  {"underground-belt", 1},
		  {"iron-plate", 5},
		  {"iron-axe", 1},
		},
		result = "subterranean-belt"
	  },
	  {
		type = "recipe",
		name = "subterranean-belt-conversion-2",
		energy = 0.5,
		enabled = "false",
		ingredients =
		{
		  {"fast-underground-belt", 1},
		  {"iron-plate", 5},
		  {"iron-axe", 1},
		},
		result = "fast-subterranean-belt"
	  },
	  {
		type = "recipe",
		name = "subterranean-belt-conversion-3",
		energy = 0.5,
		enabled = "false",
		ingredients =
		{
		  {"express-underground-belt", 1},
		  {"iron-plate", 5},
		  {"iron-axe", 1},
		},
		result = "express-subterranean-belt"
	  },
	})

	table.insert(data.raw.technology["subterranean-logistics-1"].effects, {type = "unlock-recipe", recipe = "subterranean-belt-conversion-1"})
	table.insert(data.raw.technology["subterranean-logistics-3"].effects, {type = "unlock-recipe", recipe = "subterranean-belt-conversion-3"})
	table.insert(data.raw.technology["subterranean-logistics-2"].effects, {type = "unlock-recipe", recipe = "subterranean-belt-conversion-2"})
end
--]]

if data.raw.technology["subterranean-logistics-1"] then
	local rec1 = createConversionRecipe("underground-belt", "subterranean-belt", true, "subterranean-logistics-1")
	local rec2 = createConversionRecipe("fast-underground-belt", "fast-subterranean-belt", true, "subterranean-logistics-2")
	local rec3 = createConversionRecipe("express-underground-belt", "express-subterranean-belt", true, "subterranean-logistics-3")

	--table.insert(data.raw.technology["subterranean-logistics-1"].effects, {type = "unlock-recipe", recipe = rec1.name})
	--table.insert(data.raw.technology["subterranean-logistics-2"].effects, {type = "unlock-recipe", recipe = rec2.name})
	--table.insert(data.raw.technology["subterranean-logistics-3"].effects, {type = "unlock-recipe", recipe = rec1.name})
	
	createConversionRecipe("subterranean-belt", "underground-belt", true, "subterranean-logistics-1")
end

if data.raw.tool["bob-logistic-science-pack"] then
	table.insert(data.raw["technology"]["logistics-3"].prerequisites, "robotics")
end

if data.raw.item["steel-gear-wheel"] then
	local express = {"express-transport-belt", "express-underground-belt", "express-splitter"}

	for _,rec in pairs(express) do
		replaceItemInRecipe(rec, "iron-gear-wheel", "steel-gear-wheel", Config.cheaperBelts and 0.35 or 0.5, true) --0.5 to keep the iron cost the same
		local bearings = Config.cheaperBelts and 2 or 4, Config.cheaperBelts and 2 or 5
		if rec == "express-underground-belt" then bearings = bearings*3 end
		addItemToRecipe(rec, "steel-bearing", bearings)
	end
	if data.raw.item["cobalt-steel-gear-wheel"] and data.raw.recipe["turbo-transport-belt"] then
		local turbo = {"turbo-transport-belt", "turbo-underground-belt", "turbo-splitter"}
	
		for _,rec in pairs(turbo) do
			replaceItemInRecipe(rec, "titanium-gear-wheel", "cobalt-steel-gear-wheel", 1, true)
			replaceItemInRecipe(rec, "titanium-bearing", "cobalt-steel-bearing", 1, true)
		end
	end
end

if data.raw.technology["cobalt-processing"] then
	splitTech("cobalt-processing", {"sulfur-processing"}, {"cobalt-plate", "cobalt-steel-alloy", "cobalt-steel-gear-wheel", "cobalt-steel-bearing-ball", "cobalt-steel-bearing"--[[, "cobalt-axe"--]]})
	addSciencePackToTech("cobalt-processing-2", "chemical-science-pack")
end

if data.raw.recipe["electric-furnace-2"] and data.raw.item["tungsten-plate"] then
	replaceItemInRecipe("electric-furnace-2", "tungsten-plate", "cobalt-steel-alloy", 1)
end

if data.raw.item["sodium-hydroxide"] then
	replaceItemInRecipe("chemical-science-pack", "sodium-hydroxide", "sodium-hydroxide", 3)
end

if Config.cheaperBelts and data.raw.item["nitinol-gear-wheel"] and data.raw.recipe["ultimate-transport-belt"] then
	replaceItemInRecipe("ultimate-transport-belt", "nitinol-gear-wheel", "nitinol-gear-wheel", 0.4)
	replaceItemInRecipe("ultimate-transport-belt", "nitinol-bearing", "nitinol-bearing", 0.4)
	
	local gear = nil
	local bearing = nil
	if data.raw.item["cobalt-steel-gear-wheel"] then
		gear = replaceItemInRecipe("turbo-transport-belt", "cobalt-steel-gear-wheel", "cobalt-steel-gear-wheel", 0.4)
		bearing = replaceItemInRecipe("turbo-transport-belt", "cobalt-steel-bearing", "cobalt-steel-bearing", 0.4)
		removeItemFromRecipe("express-transport-belt", "cobalt-steel-gear-wheel")
		removeItemFromRecipe("express-transport-belt", "cobalt-steel-bearing")
		if data.raw.technology["bob-logistics-4"] then
			replaceTechPrereq("bob-logistics-4", "titanium-processing", "cobalt-processing-2")
		end
	else
		gear = replaceItemInRecipe("turbo-transport-belt", "titanium-gear-wheel", "titanium-gear-wheel", 0.4)
		bearing = replaceItemInRecipe("turbo-transport-belt", "titanium-bearing", "titanium-bearing", 0.4)
	end
	
	if gear[2] == 0 then gear[2] = gear[1] end
	if gear[3] == 0 then gear[3] = gear[1] end
	if bearing[2] == 0 then bearing[2] = bearing[1] end
	if bearing[3] == 0 then bearing[3] = bearing[1] end
	
	local rec = data.raw.recipe["express-transport-belt"]
	if rec.ingredients then
		for _,ing in pairs(rec.ingredients) do
			if ing[1] == "steel-bearing" then ing[2] = bearing[1] end
			if ing[1] == "steel-gear-wheel" then ing[2] = gear[1] end
		end
	end
	if rec.normal and rec.normal.ingredients then
		for _,ing in pairs(rec.normal.ingredients) do
			if ing[1] == "steel-bearing" then ing[2] = bearing[2] end
			if ing[1] == "steel-gear-wheel" then ing[2] = gear[2] end
		end
	end
	if rec.expensive and rec.expensive.ingredients then
		for _,ing in pairs(rec.expensive.ingredients) do
			if ing[1] == "steel-bearing" then ing[2] = bearing[3] end
			if ing[1] == "steel-gear-wheel" then ing[2] = gear[3] end
		end
	end
end

if data.raw["assembling-machine"]["mixing-steel-furnace"] then
	createConversionRecipe("mixing-furnace", "mixing-steel-furnace", true, "mixing-steel-furnace")
end

if data.raw["assembling-machine"]["chemical-steel-furnace"] then
	createConversionRecipe("chemical-boiler", "chemical-steel-furnace", true, "chemical-processing-2")
end

if data.raw.technology.cathodes then
	replaceTechPrereq("cathodes", "advanced-electronics", "circuit-network")
end

if data.raw.technology["express-loader"] and data.raw.tool["bob-logistic-science-pack"] then
	replaceTechPack("express-loader", "production-science-pack", "bob-logistic-science-pack")
end

if data.raw.technology["purple-loader"] then
	local t = {data.raw.technology["loader"], data.raw.technology["fast-loader"], data.raw.technology["express-loader"], data.raw.technology["purple-loader"], data.raw.technology["green-loader"]}
	t[1].unit.count = math.min(t[1].unit.count, 100)
	t[5].unit.count = math.max(t[5].unit.count, 500)
	local diff = t[5].unit.count-t[1].unit.count
	local step = diff/4
	for i = 2,#t do
		local tech = t[i]
		local cost = (i-1)*step+t[1].unit.count
		cost = 50*math.floor(cost/50+0.5)
		tech.unit.count = cost
	end
end

if data.raw.technology["heli-technology"] then
	local tech = data.raw.technology["heli-technology"]
	if Config.splitHelicopter then
		local basic = table.deepcopy(tech)
		basic.name = "heli-technology-basic"
		basic.effects[1].recipe = "helicopter-basic"
		table.remove(basic.unit.ingredients, 3)
		basic.unit.count = math.floor(basic.unit.count*0.4)
		basic.prerequisites = {"flight", "electronics"}
		data:extend({basic})
		table.insert(tech.prerequisites, "heli-technology-basic")
	end
	if not listHasValue(tech.prerequisites, "advanced-electronics-2") then
		if not replaceTechPrereq(tech, "advanced-electronics", "advanced-electronics-2") then
			table.insert(tech.prerequisites, "advanced-electronics-2")
		end
	end
	--table.insert(tech.prerequisites, "rocketry") --since has a rocket launcher in the recipe
	
	if listHasValue(data.raw.technology["advanced-electronics-2"].prerequisites, "gold-processing") and mods["Oreverhaul"] then --ie bob logic boards, + oreverhaul means gold is VERY late, later than the heli should be
		replaceTechPrereq(tech, "advanced-electronics-2", "advanced-electronics")
		replaceItemInRecipe(tech.effects[1].recipe, "processing-unit", "advanced-circuit", 1)
	end
	
	for _,ing in pairs(tech.unit.ingredients) do
		ing[2] = 1
	end
end

if data.raw.item["mixing-furnace"] then
	createConversionRecipe("mixing-steel-furnace", "electric-mixing-furnace", true, "alloy-processing-2")
	createConversionRecipe("chemical-steel-furnace", "chemical-furnace", true, "chemical-processing-3")
end

if Config.tieredBobRobots and data.raw.item["robot-brain-logistic"] then --also do with robot frames and the tools
	for i = 1,3 do
		local suff1 = i == 1 and "" or ("-" .. i)
		local suff2 = "-" .. (i+1)
		turnRecipeIntoConversion("robot-brain-logistic" .. suff1, "robot-brain-logistic" .. suff2)
		turnRecipeIntoConversion("robot-brain-construction" .. suff1, "robot-brain-construction" .. suff2)
		turnRecipeIntoConversion("robot-tool-logistic" .. suff1, "robot-tool-logistic" .. suff2)
		turnRecipeIntoConversion("robot-tool-construction" .. suff1, "robot-tool-construction" .. suff2)
		turnRecipeIntoConversion("flying-robot-frame" .. suff1, "flying-robot-frame" .. suff2)
	end
	
	--[[
	createConversionRecipe("robot-brain-logistic" .. suff1, "robot-brain-logistic" .. suff2, true, "bob-robots-" .. i)
	createConversionRecipe("robot-brain-logistic-2", "robot-brain-logistic-3", true, "bob-robots-2")
	createConversionRecipe("robot-brain-logistic-3", "robot-brain-logistic-4", true, "bob-robots-3")
	
	createConversionRecipe("robot-brain-construction", "robot-brain-construction-2", true, "bob-robots-1")
	createConversionRecipe("robot-brain-construction-2", "robot-brain-construction-3", true, "bob-robots-2")
	createConversionRecipe("robot-brain-construction-3", "robot-brain-construction-4", true, "bob-robots-3")
	--]]
end

if Config.woodSludge and data.raw.item["wooden-gear"] then
data:extend({
  {
    type = "recipe",
    name = "wood-gear-sludge",
    category = "oil-processing",
    enabled = false,
    energy_required = 2.5,
    ingredients =
    {
      {type="item", name="wooden-gear", amount=8},
      {type="fluid", name="sulfuric-acid", amount=25},
      {type="fluid", name="steam", amount=30}
    },
    results=
    {
      {type="fluid", name="heavy-oil", amount=15},
      {type="fluid", name="light-oil", amount=35},
      --{type="item", name="coal", amount=1}
    },
    icon = "__FTweaks__/graphics/icons/wood-sludge.png",
	icon_size = 32,
    subgroup = "fluid-recipes",
    order = "a[oil-processing]-c[wood-sludge]",
    allow_decomposition = false
  },
})
table.insert(data.raw.technology["wood-sludge"].effects, {type = "unlock-recipe", recipe = "wood-gear-sludge"})
end

if data.raw.technology["electric-pole-2"] then
	replaceTechPrereq("electric-pole-2", "zinc-processing", data.raw.technology["angels-invar-smelting-1"] and "angels-invar-smelting-1" or "invar-processing")
	
	if data.raw.item["brass-alloy"] then
		replaceItemInRecipe(data.raw.recipe["medium-electric-pole-2"], "brass-alloy", "invar-alloy", 1)
		replaceItemInRecipe(data.raw.recipe["big-electric-pole-2"], "brass-alloy", "invar-alloy", 1)
	end
	
	if data.raw.technology["titanium-processing"] then
		replaceTechPrereq("electric-pole-3", "titanium-processing", "cobalt-processing")
	end
	
	if data.raw.item["titanium-plate"] then
		replaceItemInRecipe(data.raw.recipe["medium-electric-pole-3"], "titanium-plate", "cobalt-steel-alloy", 1)
		replaceItemInRecipe(data.raw.recipe["big-electric-pole-3"], "titanium-plate", "cobalt-steel-alloy", 1)
	end
end
--[[ native now
if data.raw.recipe["electrolyser-3"] and data.raw.item["tungsten-plate"] then
	replaceItemInRecipe(data.raw.recipe["electrolyser-3"], "tungsten-plate", "aluminium-plate", 1)
	replaceTechPrereq("electrolyser-3", "tungsten-processing", "aluminium-processing")
end
--]]
if data.raw.recipe["chemical-plant-3"] and data.raw.item["titanium-plate"] then
	replaceItemInRecipe(data.raw.recipe["chemical-plant-3"], "titanium-plate", "aluminium-plate", 1)
	replaceTechPrereq("chemical-plant-3", "titanium-processing", "aluminium-processing")
	table.insert(data.raw.technology["chemical-plant-3"].prerequisites, "cobalt-processing-2")
	table.insert(data.raw.technology["chemical-plant-3"].prerequisites, "zinc-processing")
	replaceItemInRecipe(data.raw.recipe["chemical-plant-3"], "titanium-bearing", "cobalt-steel-bearing", 1)
	replaceItemInRecipe(data.raw.recipe["chemical-plant-3"], "titanium-gear-wheel", "cobalt-steel-gear-wheel", 1)
	replaceItemInRecipe(data.raw.recipe["chemical-plant-3"], "titanium-pipe", "brass-pipe", 1)
end

if data.raw.recipe["storage-tank-3"] and data.raw.item["titanium-plate"] then
	replaceItemInRecipe(data.raw.recipe["storage-tank-3"], "titanium-plate", "cobalt-steel-alloy", 1)
	replaceItemInRecipe(data.raw.recipe["bob-pump-3"], "titanium-plate", "aluminium-plate", 1)
	replaceItemInRecipe(data.raw.recipe["bob-pump-2"], "aluminium-plate", "brass-gear-wheel", 1)
	replaceTechPrereq("bob-fluid-handling-3", "titanium-processing", "aluminium-processing")
	table.insert(data.raw.technology["bob-fluid-handling-3"].prerequisites, "cobalt-processing-2")
	table.insert(data.raw.technology["bob-fluid-handling-2"].prerequisites, "zinc-processing")
end

if data.raw.item["copper-pipe"] then
	replaceItemInRecipe(data.raw.recipe["steam-turbine"], "copper-plate", "copper-pipe", 0.8, true)
end

if data.raw.item["steam-engine-2"] then
	for i = 2,3 do
		local rec = createConversionRecipe("steam-engine-" .. i, i == 2 and "steam-turbine" or "steam-turbine-" .. (i-1), false, nil, {"steam-engine", "steam-engine-2", "steam-engine-3"})
		data:extend({rec})
		--error(serpent.block(ret))
		if i == 2 then
			table.insert(data.raw.technology["nuclear-power"].effects, {type = "unlock-recipe", recipe = rec.name})
			if data.raw.technology["geothermal-2"] then
				table.insert(data.raw.technology["geothermal-2"].effects, {type = "unlock-recipe", recipe = rec.name})
			end
		else
			table.insert(data.raw.technology["bob-steam-turbine-" .. (i-1)].effects, {type = "unlock-recipe", recipe = rec.name})
		end
	end
else
	local rec = createConversionRecipe("steam-engine", "steam-turbine", true)
	table.insert(data.raw.technology["nuclear-power"].effects, {type = "unlock-recipe", recipe = rec.name})
	if data.raw.technology["geothermal-2"] then
		table.insert(data.raw.technology["geothermal-2"].effects, {type = "unlock-recipe", recipe = rec.name})
	end
end

if data.raw.recipe["bob-area-mining-drill-2"] then
	for i = 1,4 do
		if data.raw.recipe["bob-area-mining-drill-" .. i] then
			createConversionRecipe("bob-mining-drill-" .. i, "bob-area-mining-drill-" .. i, true, "bob-area-drills-" .. i)
		end
	end
end

if data.raw.unit["Construction Drone"] then
	local drone = data.raw.unit["Construction Drone"]
	--table.insert(drone.collision_mask, "water-tile")
	table.insert(drone.collision_mask, "layer-44")
	
	table.insert(data.raw.tile["water"].collision_mask, "layer-44")
	table.insert(data.raw.tile["deepwater"].collision_mask, "layer-44")
	table.insert(data.raw.tile["water-green"].collision_mask, "layer-44")
	table.insert(data.raw.tile["deepwater-green"].collision_mask, "layer-44")
	table.insert(data.raw.tile["water-shallow"].collision_mask, "layer-44")
	table.insert(data.raw.tile["water-mud"].collision_mask, "layer-44")
	
	log("Set construction drone collision mask to " .. serpent.block(drone.collision_mask))
	
	if Config.invinciDrones then
		drone.destructible = false
		drone.resistances = createTotalResistance()
	end
end

local function removeBobRobochargingPadCollision(entity, large)
	data.raw.roboport[entity].collision_box = nil
	data.raw.roboport[entity].tile_height = large and 3 or 2
	data.raw.roboport[entity].tile_width = large and 3 or 2
end

if data.raw.roboport["bob-robo-charge-port-large"] then
	removeBobRobochargingPadCollision("bob-robo-charge-port")
	removeBobRobochargingPadCollision("bob-robo-charge-port-2")
	removeBobRobochargingPadCollision("bob-robo-charge-port-3")
	removeBobRobochargingPadCollision("bob-robo-charge-port-4")
	removeBobRobochargingPadCollision("bob-robo-charge-port-large", true)
	removeBobRobochargingPadCollision("bob-robo-charge-port-large-2", true)
	removeBobRobochargingPadCollision("bob-robo-charge-port-large-3", true)
	removeBobRobochargingPadCollision("bob-robo-charge-port-large-4", true)
end

if data.raw["assembling-machine"]["electric-offshore-pump"] then
	data.raw["assembling-machine"]["electric-offshore-pump"].energy_usage = "90kW"
end

if data.raw.item["lead-plate"] then
	replaceItemInRecipe(data.raw.recipe["battery"], "lead-plate", "lead-plate", 3, true)
end

if data.raw.technology["Schall-pickup-tower-1"] then
	replaceItemInRecipe("Schall-pickup-tower-R32", "advanced-circuit", "electronic-circuit", 5, true)
	data.raw.technology["Schall-pickup-tower-1"].prerequisites = {"electronics", "electric-energy-distribution-1"}
	removeSciencePackFromTech("Schall-pickup-tower-1", "military-science-pack")
	removeSciencePackFromTech("Schall-pickup-tower-1", "chemical-science-pack")
	data.raw.technology["Schall-pickup-tower-2"].prerequisites = {"advanced-electronics", "Schall-pickup-tower-1", "electric-energy-distribution-2", "construction-robotics"}
	removeSciencePackFromTech("Schall-pickup-tower-2", "military-science-pack")
	
	replaceItemInRecipe("Schall-pickup-tower-R64", "Schall-pickup-tower-R32", "Schall-pickup-tower-R32", 0.5, true)
	replaceItemInRecipe("Schall-pickup-tower-R96", "Schall-pickup-tower-R64", "Schall-pickup-tower-R64", 0.5, true)
	replaceItemInRecipe("Schall-pickup-tower-R128", "Schall-pickup-tower-R96", "Schall-pickup-tower-R96", 0.5, true)
end

if data.raw.boiler["oil-steam-boiler"] and data.raw.boiler["boiler-2"] then
	data.raw.boiler["oil-steam-boiler"].target_temperature = data.raw.boiler["boiler-2"].target_temperature
	data.raw.boiler["oil-steam-boiler"].energy_consumption = data.raw.boiler["boiler-3"].energy_consumption
end

local function applyToBobGemRecipe(rec, frac)
	rec = data.raw.recipe[rec]
	convertRecipeToResultTable(rec)
	rec.results[1].probability = Config.gemEfficiency
	rec.results[1].amount_min = 1
	rec.results[1].amount_max = 1
end

if Config.gemEfficiency < 1 and data.raw.item["ruby-4"] then
	applyToBobGemRecipe("bob-ruby-4")
	applyToBobGemRecipe("bob-sapphire-4")
	applyToBobGemRecipe("bob-emerald-4")
	applyToBobGemRecipe("bob-amethyst-4")
	applyToBobGemRecipe("bob-topaz-4")
	applyToBobGemRecipe("bob-diamond-4")
end

if data.raw.inserter["turbo-stack-filter-inserter"] then
	data.raw.inserter["stack-filter-inserter"].filter_count = 3 --this is the blue one; express-stack-filter-inserter, while it exists, is not used, and the red one is a custom reimpl
	data.raw.inserter["turbo-stack-filter-inserter"].filter_count = 5
end

local function ensureContactsInBobModule(recipe)
	local rec = data.raw["recipe"][recipe]
	if rec then
		addItemToRecipe(rec, "module-contact", 5)
	end
end

if data.raw.item["module-contact"] then
	ensureContactsInBobModule("speed-module-3")
	ensureContactsInBobModule("effectivity-module-3")
	ensureContactsInBobModule("productivity-module-3")
	ensureContactsInBobModule("pollution-clean-module-3")
	ensureContactsInBobModule("raw-speed-module-3")
	ensureContactsInBobModule("raw-productivity-module-3")
	ensureContactsInBobModule("green-module-3")
end