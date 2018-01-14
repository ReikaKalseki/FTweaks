require "functions"

local function createVoidRecipe(fluid)
	if data.raw.fluid[fluid] then
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
						table.insert(ingredients, item)
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
						table.insert(ingredients, item)
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
			ingredients = ingredients--[[
			{
			  {"low-density-structure", 100},
			  {"solar-panel", 100},
			  {"large-accumulator", 80},
			  {"radar", 5},
			  {"processing-unit", 100},
			  {"rocket-fuel", 50}
			}--]],
			result = "satellite",
			expensive = (exp and norm) and {
				ingredients = exp,
				energy_required = data.raw.recipe["satellite"].energy_required,
				result = "satellite",
			} or nil,
			normal = (exp and norm) and {
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
end