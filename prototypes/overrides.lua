require("config")

data.raw["pipe-to-ground"]["pipe-to-ground"].fast_replaceable_group = "pipe-to-ground"

data.raw["electric-pole"]["small-electric-pole"].fast_replaceable_group = "powerpole"
data.raw["electric-pole"]["medium-electric-pole"].fast_replaceable_group = "powerpole"

if data.raw["electric-pole"]["medium-electric-pole-2"] then
	data.raw["electric-pole"]["small-electric-pole-2"].fast_replaceable_group = "powerpole"
	data.raw["electric-pole"]["medium-electric-pole-2"].fast_replaceable_group = "powerpole"
end
if data.raw["electric-pole"]["medium-electric-pole-3"] then
	data.raw["electric-pole"]["small-electric-pole-3"].fast_replaceable_group = "powerpole"
	data.raw["electric-pole"]["medium-electric-pole-3"].fast_replaceable_group = "powerpole"
end
if data.raw["electric-pole"]["medium-electric-pole-4"] then
	data.raw["electric-pole"]["small-electric-pole-4"].fast_replaceable_group = "powerpole"
	data.raw["electric-pole"]["medium-electric-pole-4"].fast_replaceable_group = "powerpole"
end
if data.raw["electric-pole"]["medium-electric-pole-5"] then
	data.raw["electric-pole"]["small-electric-pole-5"].fast_replaceable_group = "powerpole"
	data.raw["electric-pole"]["medium-electric-pole-5"].fast_replaceable_group = "powerpole"
end

-- Stack Sizes
if Config.stackSize then
	data.raw.item["stone"].stack_size = 200
	data.raw.item["coal"].stack_size = 200
	data.raw.item["iron-ore"].stack_size = 200
	data.raw.item["copper-ore"].stack_size = 200
	data.raw.item["sulfur"].stack_size = 200
	data.raw.item["raw-wood"].stack_size = 200

	data.raw.item["iron-plate"].stack_size = 200
	data.raw.item["copper-plate"].stack_size = 200
	data.raw.item["steel-plate"].stack_size = 200

	data.raw.item["plastic-bar"].stack_size = 200
	data.raw.item["stone-brick"].stack_size = 200
	data.raw.item["battery"].stack_size = 200
	data.raw.item["stone-wall"].stack_size = 100

	data.raw.item["rocket-fuel"].stack_size = 50
	data.raw.item["low-density-structure"].stack_size = 50

	if data.raw.item["fluorite"] then
		data.raw.item["fluorite"].stack_size = 200
		data.raw.item["uraninite"].stack_size = 200
	end
end

-- Cheaper Steel
if Config.cheapSteel then
	data.raw.recipe["steel-plate"].energy = 7
	data.raw.recipe["steel-plate"].ingredients = {{"iron-plate", 2}}
end

--TEMP
--[[
data.raw["radar"]["radar"].energy_per_sector = "0.7MJ"
data.raw["radar"]["radar"].max_distance_of_sector_revealed = 30
data.raw["radar"]["radar"].energy_usage = "3MW"
data.raw["solar-panel"]["solar-panel-5"].production = "90MW"
--]]

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
	
-- fluid color correction
data.raw["fluid"]["heavy-oil"].base_color = {r=0.906, g=0.376, b=0.145}
data.raw["fluid"]["heavy-oil"].flow_color = {r=1, g=0.635, b=0.267}

data.raw["fluid"]["petroleum-gas"].base_color = {r=0.741, g=0.741, b=0.741}
data.raw["fluid"]["petroleum-gas"].flow_color = {r=0.282, g=0.282, b=0.282}

data.raw["fluid"]["sulfuric-acid"].base_color = {r=0, g=0.7, b=0.788}

if data.raw["technology"]["fast-loader"] then
	table.insert(data.raw["technology"]["fast-loader"].prerequisites,"loader")
	table.insert(data.raw["technology"]["express-loader"].prerequisites,"fast-loader")
	if data.raw["technology"]["green-loader"] then
		table.insert(data.raw["technology"]["green-loader"].prerequisites,"express-loader")
		table.insert(data.raw["technology"]["purple-loader"].prerequisites,"green-loader")
	end
end

-- tougher endgame
if Config.harderSilo then
	data.raw["technology"]["rocket-silo"].unit.count = data.raw["technology"]["rocket-silo"].unit.count*10
	table.insert(data.raw["technology"]["rocket-silo"].prerequisites,"military-4")

	if data.raw["technology"]["speed-module-5"] then
		table.insert(data.raw["technology"]["rocket-silo"].prerequisites,"speed-module-5")
	end
	if data.raw["technology"]["productivity-module-5"] then
		table.insert(data.raw["technology"]["rocket-silo"].prerequisites,"productivity-module-5")
	end
	if data.raw["technology"]["effectivity-module-5"] then
		table.insert(data.raw["technology"]["rocket-silo"].prerequisites,"effectivity-module-5")
	end
	if data.raw["technology"]["plasma-turret-damage-10"] then
		table.insert(data.raw["technology"]["rocket-silo"].prerequisites,"plasma-turret-damage-10")
	end
	--[[
	if data.raw["technology"]["follower-robot-count-20"] then
		table.insert(data.raw["technology"]["rocket-silo"].prerequisites,"follower-robot-count-20")
	end
	--]]

	data.raw["recipe"]["satellite"].energy = 600
	data.raw["recipe"]["rocket-part"].energy = 120
	
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
		if item[1] == "solar-panel" and data.raw.item["solar-panel-5"] then
			item[1] = "solar-panel-5"
		end
		if item[1] == "processing-unit" then
			circuitcount = item[2]
		end
		table.insert(satparts, item)
	end
	if data.raw.item["advanced-processing-unit"] then
		table.insert(satparts, {"advanced-processing-unit", math.floor(circuitcount/2)})
	end
	table.insert(satparts, item)
	
	data.raw["recipe"]["satellite"].ingredients = satparts
	
	if data.raw.item["titanium-plate"] then
		table.insert(data.raw["recipe"]["low-density-structure"].ingredients, {"titanium-plate", 5})
	end
	if data.raw.item["tungsten-plate"] then
		table.insert(data.raw["recipe"]["low-density-structure"].ingredients, {"tungsten-plate", 2})
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
	
	data.raw["recipe"]["rocket-control-unit"].energy = data.raw["recipe"]["rocket-control-unit"].energy*10
	data.raw["recipe"]["low-density-structure"].energy = data.raw["recipe"]["low-density-structure"].energy*4
	data.raw["recipe"]["rocket-fuel"].energy = data.raw["recipe"]["rocket-fuel"].energy*5
	
	data.raw["recipe"]["rocket-fuel"].category = "chemistry"--"crafting-with-fluid"
	table.insert(data.raw["recipe"]["rocket-fuel"].ingredients, {type="fluid", name = "hydrogen", amount = 20})
	table.insert(data.raw["recipe"]["rocket-fuel"].ingredients, {type="fluid", name = "nitrogen", amount = 10})
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

if data.raw["underground-belt"]["green-underground-belt"] then
	data.raw["underground-belt"]["green-underground-belt"].max_distance = 30
	data.raw["underground-belt"]["green-underground-belt"].speed = 0.15
	data.raw["transport-belt"]["green-transport-belt"].speed = 0.15
end

if data.raw["underground-belt"]["purple-underground-belt"] then
	data.raw["underground-belt"]["purple-underground-belt"].max_distance = 40
	data.raw["underground-belt"]["purple-underground-belt"].speed = 0.2
	data.raw["transport-belt"]["purple-transport-belt"].speed = 0.2
end

if data.raw["pipe"]["stone-pipe"] then
	data.raw["pipe"]["stone-pipe"].fluid_box.base_area = 4
end
if data.raw["pipe-to-ground"]["stone-pipe-to-ground"] then
	data.raw["pipe-to-ground"]["stone-pipe-to-ground"].fluid_box.base_area = 4
end

if data.raw["boiler"]["boiler-2"] then
	data.raw["boiler"]["boiler-2"].fluid_box.base_area = 2
	data.raw["boiler"]["boiler-3"].fluid_box.base_area = 4
	data.raw["boiler"]["boiler-4"].fluid_box.base_area = 8
end

if data.raw["storage-tank"]["rail-tanker-proxy"] then
	data.raw["storage-tank"]["rail-tanker-proxy"].fluid_box.base_area = 1000 --was 250
end

if data.raw.locomotive["bob-diesel-locomotive-3"] then
	data.raw.locomotive["bob-diesel-locomotive-3"].max_speed = 3
end

if data.raw.recipe["basic-circuit-board"] then
	data.raw.recipe["basic-circuit-board"].energy = 0.5
end

if data.raw.recipe["solder"] then
	data.raw.recipe["solder"].energy = 0.5
end

if data.raw.recipe["large-accumulator"] then
		if not Config.harderSilo then
			local ingredients = {}
			local accucount = 0
			for k,item in pairs(data.raw.recipe["satellite"].ingredients) do
				if item[1] == "accumulator" then
					accucount = item[2]
				else
					table.insert(ingredients, item)
				end
			end
			table.insert(ingredients, {"large-accumulator", math.floor(accucount*0.8)})
		end
		
	data:extend(
	{
	  {
		type = "recipe",
		name = "large-accumulator-conversion",
		energy = 8,
		enabled = "true",
		ingredients =
		{
		  {"iron-plate", 1},
		  {"battery", 5},
		  {"accumulator", 1},
		},
		result = "large-accumulator"
	  }
	})

	if not Config.harderSilo then
		data:extend(
		{
		  {
			type = "recipe",
			name = "large-accumulator-satellite",
			energy = data.raw.recipe["satellite"].energy,
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
			result = "satellite"
		  }
		})
	end
	 
	table.insert(data.raw.technology["bob-electric-energy-accumulators-2"].effects, {type = "unlock-recipe", recipe = "large-accumulator-conversion"})
	 
	if not Config.harderSilo then
		table.insert(data.raw.technology["rocket-silo"].effects, {type = "unlock-recipe", recipe = "large-accumulator-satellite"})
	end
end

if data.raw.recipe["chemical-furnace"] then
	data:extend(
	{
	  {
		type = "recipe",
		name = "chemical-furnace-conversion",
		energy = 8,
		enabled = "true",
		ingredients =
		{
		  {"electric-furnace", 1},
		  {"steel-pipe", 5},
		},
		result = "chemical-furnace"
	  }
	})
	 
	 table.insert(data.raw.technology["chemical-processing-3"].effects, {type = "unlock-recipe", recipe = "chemical-furnace-conversion"})
end

if data.raw.recipe["electric-chemical-mixing-furnace"] and data.raw.recipe["chemical-furnace-conversion"] then
	data:extend(
	{
	  	  {
		type = "recipe",
		name = "chemical-furnace-conversion-2",
		energy = 8,
		enabled = "true",
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
		enabled = "true",
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
	 
	 table.insert(data.raw.technology["chemical-processing-3"].effects, {type = "unlock-recipe", recipe = "chemical-furnace-conversion-2"})
	 table.insert(data.raw.technology["chemical-processing-3"].effects, {type = "unlock-recipe", recipe = "chemical-furnace-conversion-3"})
end

if data.raw["generator"]["wind-turbine"] then
	data.raw["generator"]["wind-turbine"].effectivity = 4--was 1.5
	data.raw.recipe["wind-turbine"].ingredients =
    {
      {"iron-plate", 1},
      {"iron-gear-wheel", 2},
      {"copper-cable", 3},
      {"iron-stick", 3}
    }
end

for k,robot in pairs(data.raw["construction-robot"]) do
	robot.resistances = { { type = "fire", percent = 100 } }
end


--data.raw["offshore-pump"]["offshore-pump"].fluid_box.base_area = 4
--data.raw["offshore-pump"]["offshore-pump"].pumping_speed = 4
--[[
if data.raw["pump"]["pump-mk3"] == nil then
	data.raw["pump"]["small-pump"].fluid_box.base_area = 4
	data.raw["pump"]["small-pump"].pumping_speed = 1.5
end
-]]