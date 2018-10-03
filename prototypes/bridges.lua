require "functions"
require "config"

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
	
	--[[	
	data:extend({
	  {
		type = "recipe",
		name = "large-accumulator-conversion",
		energy = 8,
		enabled = "false",
		ingredients =
		{
		  {"iron-plate", 1},
		  {"battery", 5},
		  {"accumulator", 1},
		},
		result = "large-accumulator"
	  }
	})
	--]]
	
	local rec = createConversionRecipe("accumulator", "large-accumulator", true, "bob-electric-energy-accumulators-2")

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
	table.insert(data.raw.technology["subterranean-logistics-2"].effects, {type = "unlock-recipe", recipe = "subterranean-belt-conversion-2"})
	table.insert(data.raw.technology["subterranean-logistics-3"].effects, {type = "unlock-recipe", recipe = "subterranean-belt-conversion-3"})
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

if data.raw.tool["logistic-science-pack"] then
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
	splitTech("cobalt-processing", {"sulfur-processing"}, {"cobalt-plate", "cobalt-steel-alloy", "cobalt-steel-gear-wheel", "cobalt-steel-bearing-ball", "cobalt-steel-bearing", "cobalt-axe"})
	addSciencePackToTech("cobalt-processing-2", "science-pack-3")
end

if data.raw.recipe["electric-furnace-2"] then
	replaceItemInRecipe("electric-furnace-2", "tungsten-plate", "cobalt-steel-alloy", 1)
end

if Config.cheaperBelts and data.raw.item["ultimate-transport-belt"] then
	replaceItemInRecipe("ultimate-transport-belt", "nitinol-gear-wheel", "nitinol-gear-wheel", 0.4)
	replaceItemInRecipe("ultimate-transport-belt", "nitinol-bearing", "nitinol-bearing", 0.4)
	
	local gear = nil
	local bearing = nil
	if data.raw.item["cobalt-steel-gear-wheel"] then
		gear = replaceItemInRecipe("turbo-transport-belt", "cobalt-steel-gear-wheel", "cobalt-steel-gear-wheel", 0.4)
		bearing = replaceItemInRecipe("turbo-transport-belt", "cobalt-steel-bearing", "cobalt-steel-bearing", 0.4)
		replaceTechPrereq("bob-logistics-4", "titanium-processing", "cobalt-processing-2")
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

if data.raw.technology["express-loader"] and data.raw.tool["logistic-science-pack"] then
	replaceTechPack("express-loader", "production-science-pack", "logistic-science-pack")
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
	if not replaceTechPrereq(tech, "advanced-electronics", "advanced-electronics-2") then
		table.insert(tech.prerequisites, "advanced-electronics-2")
	end
	table.insert(tech.prerequisites, "rocketry") --since has a rocket launcher in the recipe
	
	if listHasValue(data.raw.technology["advanced-electronics-2"].prerequisites, "gold-processing") and mods["Oreverhaul"] then --ie bob logic boards, + oreverhaul means gold is VERY late, later than the heli should be
		replaceTechPrereq(tech, "advanced-electronics-2", "advanced-electronics")
		replaceItemInRecipe(tech.effects[1].recipe, "processing-unit", "advanced-circuit", 1)
	end
	
	for _,ing in pairs(tech.unit.ingredients) do
		ing[2] = 1
	end
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
	
	replaceItemInRecipe(data.raw.recipe["medium-electric-pole-2"], "brass-alloy", "invar-alloy", 1)
	replaceItemInRecipe(data.raw.recipe["big-electric-pole-2"], "brass-alloy", "invar-alloy", 1)
	
	replaceTechPrereq("electric-pole-3", "titanium-processing", "cobalt-processing")
	
	replaceItemInRecipe(data.raw.recipe["medium-electric-pole-3"], "titanium-plate", "cobalt-steel-alloy", 1)
	replaceItemInRecipe(data.raw.recipe["big-electric-pole-3"], "titanium-plate", "cobalt-steel-alloy", 1)
end