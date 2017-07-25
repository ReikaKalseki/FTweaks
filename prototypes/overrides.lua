require("config")

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

function increaseStackSize(item, amt)
	data.raw.item[item].stack_size = math.max(data.raw.item[item].stack_size, amt)
end

-- Stack Sizes
if Config.stackSize then
	increaseStackSize("stone", 200)
	increaseStackSize("coal", 200)
	increaseStackSize("iron-ore", 200)
	increaseStackSize("copper-ore", 200)
	increaseStackSize("uranium-ore", 200)
	increaseStackSize("sulfur", 200)
	increaseStackSize("raw-wood", 200)

	increaseStackSize("iron-plate", 200)
	increaseStackSize("copper-plate", 200)
	increaseStackSize("steel-plate", 200)

	increaseStackSize("plastic-bar", 200)
	increaseStackSize("stone-brick", 200)
	increaseStackSize("battery", 200)
	increaseStackSize("stone-wall", 100)
	
	increaseStackSize("concrete", 500)
	increaseStackSize("landfill", 500)

	increaseStackSize("rocket-fuel", 50)
	increaseStackSize("low-density-structure", 50)
end

-- Cheaper Steel
if Config.cheapSteel then
	data.raw.recipe["steel-plate"].normal.energy_required = 7.5
	data.raw.recipe["steel-plate"].normal.ingredients = {{"iron-plate", 2}}
	data.raw.recipe["steel-plate"].expensive.energy_required = 15
	data.raw.recipe["steel-plate"].expensive.ingredients = {{"iron-plate", 5}}
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

--table.insert(data.raw["heat-pipe"]["heat-pipe"].flags, "placeable-off-grid")
--table.insert(data.raw["heat-pipe"]["heat-pipe"].flags, "not-on-map")
--data.raw["heat-pipe"]["heat-pipe"].collision_mask = {} --makes heat pipes placeable on top of each other

if data.raw["technology"]["fast-loader"] then
	table.insert(data.raw["technology"]["fast-loader"].prerequisites,"loader")
	table.insert(data.raw["technology"]["express-loader"].prerequisites,"fast-loader")
	if data.raw["technology"]["green-loader"] then
		table.insert(data.raw["technology"]["green-loader"].prerequisites,"express-loader")
		table.insert(data.raw["technology"]["purple-loader"].prerequisites,"green-loader")
	end
	data.raw["technology"]["loader"].prerequisites = {"railway", "logistics-2"}
end

data.raw["technology"]["flying"].prerequisites = {"engine", "advanced-electronics", "advanced-material-processing"}

if Config.harderNuclear then
	data.raw["technology"]["nuclear-power"].prerequisites = {"advanced-electronics-2", "concrete", "advanced-material-processing-2", "electric-energy-distribution-2", "circuit-network", "robotics"}
	table.insert(data.raw["technology"]["nuclear-power"].unit.ingredients, {"high-tech-science-pack", 1})
	table.insert(data.raw["technology"]["nuclear-power"].unit.ingredients, {"production-science-pack", 1})
end

table.insert(data.raw["technology"]["electric-energy-distribution-2"].prerequisites,"advanced-electronics")

data.raw.item["rocket-silo"].subgroup = "production-machine"

data:extend(
{
  {
    type = "recipe-category",
    name = "manual-crafting"
  },
})


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
		table.insert(data.raw["technology"]["rocket-silo"].prerequisites,"plasma-turret-damage-9") --not 10, as that requires space science
	end
	--[[
	if data.raw["technology"]["follower-robot-count-20"] then
		table.insert(data.raw["technology"]["rocket-silo"].prerequisites,"follower-robot-count-20")
	end
	--]]

	data.raw["recipe"]["satellite"].energy_required = 600
	data.raw["recipe"]["rocket-part"].energy_required = 120
	
	data.raw["recipe"]["rocket-silo"].category = "manual-crafting"
	table.insert(data.raw.player["player"].crafting_categories,"manual-crafting")
	
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
	if data.raw.item["plutonium"] then --RTG
		table.insert(satparts, {"plutonium", 2})
		table.insert(data.raw.technology["rocket-silo"].prerequisites, "kovarex-enrichment-process")
	end
	table.insert(satparts, item)
	
	data.raw["recipe"]["satellite"].ingredients = satparts
	for i = 8,3,-1 do
		if data.raw["assembling-machine"]["assembling-machine-" .. i] then
			data.raw["assembling-machine"]["assembling-machine-" .. i].ingredient_count = math.max(data.raw["assembling-machine"]["assembling-machine-" .. i].ingredient_count, #satparts) --ensure craftability in the highest assembling machine tier
			break
		end
	end
	
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
	
	data.raw["recipe"]["rocket-control-unit"].energy_required = data.raw["recipe"]["rocket-control-unit"].energy_required*10
	data.raw["recipe"]["low-density-structure"].normal.energy_required = data.raw["recipe"]["low-density-structure"].normal.energy_required*4
	data.raw["recipe"]["low-density-structure"].expensive.energy_required = data.raw["recipe"]["low-density-structure"].expensive.energy_required*4
	data.raw["recipe"]["rocket-fuel"].energy_required = data.raw["recipe"]["rocket-fuel"].energy_required*5
	table.insert(data.raw["recipe"]["rocket-fuel"].ingredients, {"steel-plate", 2})
	
	if data.raw.fluid["hydrogen"] then
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

--[[
if data.raw["pipe"]["stone-pipe"] then
	data.raw["pipe"]["stone-pipe"].fluid_box.base_area = 4
end
if data.raw["pipe-to-ground"]["stone-pipe-to-ground"] then
	data.raw["pipe-to-ground"]["stone-pipe-to-ground"].fluid_box.base_area = 4
end
--]]

data.raw["assembling-machine"]["assembling-machine-3"].crafting_speed = 1.5 --vanilla is 1.25, which is LESS than a tier2 with the four speed modules

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
	data.raw["boiler"]["boiler-2"].fluid_box.base_area = 2
	data.raw["boiler"]["boiler-3"].fluid_box.base_area = 4
	data.raw["boiler"]["boiler-4"].fluid_box.base_area = 8
end
--]]

if data.raw.locomotive["bob-diesel-locomotive-3"] then
	data.raw.locomotive["bob-diesel-locomotive-3"].max_speed = 3
end

if data.raw.recipe["basic-circuit-board"] then
	data.raw.recipe["basic-circuit-board"].energy_required = 0.5
end

if data.raw.recipe["solder"] then
	data.raw.recipe["solder"].energy_required = 0.5
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
	spawner.resistances = createSpawnerResistance(spawner)
end

data.raw.unit["medium-biter"].attack_parameters.range = 0.9 --was 1.0, allowing through-wall attacks

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
			energy = data.raw.recipe["satellite"].energy_required,
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

for name,radar in pairs(data.raw.radar) do --by default radar amplification adds 2 "active scan" and 3 "region scan" per level; this changes it to 0/5, so that one radar cannot active scan a huge area, and compensates by increasing search range
	if string.find(name, "big_brother", 1, true) then
		local amp = (radar.max_distance_of_sector_revealed-data.raw.radar.radar.max_distance_of_sector_revealed)/3
		if amp > 0 then
			radar.max_distance_of_nearby_sector_revealed = data.raw.radar.radar.max_distance_of_nearby_sector_revealed
			radar.max_distance_of_sector_revealed = radar.max_distance_of_sector_revealed+amp*2
		end
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

if data.raw.recipe["breeder-fuel-cell"] then
	table.insert(data.raw.technology["kovarex-enrichment-process"].effects, {type = "unlock-recipe", recipe = "kovarex-enrichment-process"})
end