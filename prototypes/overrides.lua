data.raw["pipe-to-ground"]["pipe-to-ground"].fast_replaceable_group = "pipe-to-ground"

-- Stack Sizes
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

-- Cheaper Steel
data.raw.recipe["steel-plate"].energy_required = 7
data.raw.recipe["steel-plate"].ingredients = {{"iron-plate", 2}}

-- Cheaper purple potions
data.raw.recipe["alien-science-pack"].result_count = 20

-- Cheaper modules (remove alien artifact)
data.raw["recipe"]["speed-module-3"].ingredients =
    {
      {"speed-module-2", 4},
      {"advanced-circuit", 5},
      {"processing-unit", 5},
      --{"alien-artifact", 1}
    }
data.raw["recipe"]["productivity-module-3"].ingredients =
    {
      {"productivity-module-2", 5},
      {"advanced-circuit", 5},
      {"processing-unit", 5},
      --{"alien-artifact", 1}
    }
data.raw["recipe"]["effectivity-module-3"].ingredients =
    {
      {"effectivity-module-2", 5},
      {"advanced-circuit", 5},
      {"processing-unit", 5},
      --{"alien-artifact", 1}
    }
	
-- fluid color correction
data.raw["fluid"]["heavy-oil"].base_color = {r=0.906, g=0.376, b=0.145}
data.raw["fluid"]["heavy-oil"].flow_color = {r=1, g=0.635, b=0.267}

data.raw["fluid"]["petroleum-gas"].base_color = {r=0.741, g=0.741, b=0.741}
data.raw["fluid"]["petroleum-gas"].flow_color = {r=0.282, g=0.282, b=0.282}

data.raw["fluid"]["sulfuric-acid"].base_color = {r=0, g=0.7, b=0.788}

-- tougher endgame
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
if data.raw["technology"]["follower-robot-count-20"] then
	table.insert(data.raw["technology"]["rocket-silo"].prerequisites,"follower-robot-count-20")
end

data.raw["recipe"]["satellite"].energy_required = 600
data.raw["recipe"]["rocket-part"].energy_required = 120

if data.raw["transport-belt-to-ground"]["green-transport-belt-to-ground"] then
	data.raw["transport-belt-to-ground"]["green-transport-belt-to-ground"].max_distance = 30
	data.raw["transport-belt-to-ground"]["green-transport-belt-to-ground"].speed = 0.15
	data.raw["transport-belt"]["green-transport-belt"].speed = 0.15
end

if data.raw["transport-belt-to-ground"]["purple-transport-belt-to-ground"] then
	data.raw["transport-belt-to-ground"]["purple-transport-belt-to-ground"].max_distance = 40
	data.raw["transport-belt-to-ground"]["purple-transport-belt-to-ground"].speed = 0.2
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

if data.raw.item["fluorite"] then
	data.raw.item["fluorite"].stack_size = 200
	data.raw.item["uraninite"].stack_size = 200
end

if data.raw["storage-tank"]["rail-tanker-proxy"] then
	data.raw["storage-tank"]["rail-tanker-proxy"].fluid_box.base_area = 1000 --was 250
end


--data.raw["offshore-pump"]["offshore-pump"].fluid_box.base_area = 4
--data.raw["offshore-pump"]["offshore-pump"].pumping_speed = 4
--[[
if data.raw["pump"]["pump-mk3"] == nil then
	data.raw["pump"]["small-pump"].fluid_box.base_area = 4
	data.raw["pump"]["small-pump"].pumping_speed = 1.5
end
-]]