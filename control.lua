require "config"

function initGlobal(force)
	if not global.ftweaks then
		global.ftweaks = {}
	end
	if force or global.ftweaks.ranTick == nil then
		global.ftweaks.ranTick = false
	end
end

local modifiers = {
	["worker-robot-speed"] = "worker_robots_speed_modifier",
	["worker-robot-battery"] = "worker_robots_battery_modifier",
	["worker-robot-storage"] = "worker_robots_storage_bonus",
	["maximum-following-robots-count"] = "maximum_following_robot_count",
	["num-quick-bars"] = "quickbar_count",
	["character-logistic-slots"] = "character_logistic_slot_count",
	["laboratory-speed"] = "laboratory_speed_modifier",
	["mining-drill-productivity-bonus"] = "mining_drill_productivity_bonus",
	["?"] = "manual_crafting_speed_modifier",
	["?"] = "manual_mining_speed_modifier",
	["?"] = "character_running_speed_modifier",
	["?"] = "character_build_distance_bonus",
	["?"] = "character_reach_distance_bonus",
	["?"] = "character_resource_reach_distance_bonus",
	["?"] = "character_item_pickup_distance_bonus",
	["?"] = "character_loot_pickup_distance_bonus",
	["?"] = "character_inventory_slots_bonus",
	["?"] = "character_health_bonus",
	["train-braking-force-bonus"] = "train_braking_force_bonus",
	--["inserter-stack-size-bonus"] = "inserter_stack_size_bonus",
	--[""] = "",
}

local function getAllPreReqs(list, tech)
	for name,pre in pairs(tech.prerequisites) do
		list[name] = pre
		getAllPreReqs(list, pre)
	end
	return list
end

local function getPreReqBonus(tech, type)
	local sum = 0
	for name,pre in pairs(getAllPreReqs({}, tech)) do
		for _,effect in pairs(pre.effects) do
			if effect.type == type then
				sum = sum+effect.modifier
			end
		end
	end
	return sum
end

local function recalcModifier(force, tech, effect)
	local val = effect.modifier
	local type = effect.type
	local get = modifiers[type]
	game.print("Found " .. (get and get or "nil") .. " for " .. type)
	if get then
		local pre = getPreReqBonus(tech, type)
		force[get] = math.max(force[get], pre+val)
		game.print("Setting " .. get .. " to " .. pre+val)
	end
end

local function doOneTick()
	for _,force in pairs(game.forces) do
		force.reset_recipes()
		force.reset_technologies()
		for _,tech in pairs(force.technologies) do
			for _,effect in pairs(tech.effects) do
				if effect.type == "unlock-recipe" then
					force.recipes[effect.recipe].enabled = tech.researched
				elseif effect.modifier then
					--recalcModifier(force, tech, effect)
				end
			end
		end
	end
	if game.players and #game.players > 0 and game.players["Reika"] then
		game.players["Reika"].color = {r=0.2, g=0.7, b=1.0, a=1.0}
	end
end

initGlobal(true)

script.on_load(function()
	
end)

script.on_init(function()
	initGlobal(true)
end)

script.on_configuration_changed(function()
	initGlobal(true)
end)
--[[
local function convertDirtyOre(player)
	local flag = true
	local convert = 0
	local converted = 0
	local inv = player.get_inventory(defines.inventory.player_main)
	while flag do
		local rem = inv.remove({name="iron-ore", count=5})
		if rem ~= 5 then
			if rem > 0 then
				inv.insert({name="iron-ore", count=rem})
			end
			flag = false
		else
			convert = convert+5
			converted = converted+7
			local add = inv.insert({name="dirty-ore-iron-ore", count=7})
			if add < 7 then
				local spill = 7-add
				player.surface.spill_item_stack(player.position, {name="dirty-ore-iron-ore", count=spill}, true)
				flag = false
			end
		end
	end
	if converted > 0 then
		game.print("Converted " .. convert .. " iron to " .. converted .. " dirty ore.")
	end
end
--]]
--local strees = {}

script.on_event(defines.events.on_tick, function(event)
	initGlobal(false)
	if not global.ftweaks.ranTick then
		doOneTick()
		global.ftweaks.ranTick = true
		game.print("FTweaks: Game state changed; reloading caches.")
	end
	--[[
	local player = game.players["Reika"]
	local trees = player.surface.find_entities_filtered({type="tree", area = {{player.position.x-50, player.position.y-50}, {player.position.x+50, player.position.y+50}}})
	for _,tree in pairs(trees) do
		local flag = true
		for _,tree2 in pairs(strees) do
			if tree2.position.x == tree.position.x and tree2.position.y == tree.position.y then
				flag = false
			end
		end
		if flag then
			local pos = tree.position
			local name = tree.name
			local dir = tree.direction
			local force = tree.force
			tree.destroy()
			table.insert(strees, player.surface.create_entity({name=name, position=pos, direction=dir, force=force, fast_replace = true}))
		end
	end
	--]]
	--[[
	if game.tick%900 == 0 and game.players.Reika then
		convertDirtyOre(game.players["Reika"])
	end
	--]]
end)

script.on_event(defines.events.on_player_joined_game, function(event)
	if game.players and #game.players > 0 and game.players[event.player_index].name == "Reika" then
		game.players[event.player_index].color = {r=0.2, g=0.7, b=1.0, a=1.0}
		game.print("Rawr")
		game.speed = 55/60
		--convertDirtyOre(game.players[event.player_index])
	end
end)

local function getRocketEvoIncrease(evo)
	if evo <= 0.5 then
		return evo/100 --0.01% for every evo %; reaches 0.5% at evo 50%
	end
	if evo <= 0.9 then --hold that to 90%
		return 0.005
	end
	if evo <= 0.95 then --rapidly increase to up to 1% at 95%
		return 0.005+(evo-0.9)/(0.05)*0.005
	end
	return 0.01*(1-evo)/0.05 --ramp back down to 0% at 100%
end

script.on_event(defines.events.on_rocket_launched, function(event)
	if Config.harderRockets then
		game.forces.enemy.evolution_factor = math.min(1, game.forces.enemy.evolution_factor+getRocketEvoIncrease(game.forces.enemy.evolution_factor))
		local size = math.random(200, 500)
		local radius = math.random(800, 2000)
		local biters = event.rocket_silo.surface.set_multi_command{command={type=defines.command.attack_area, destination=event.rocket_silo.position, radius=80, distraction=defines.distraction.none}, unit_count=size, force=game.forces.enemy, unit_search_distance=radius}
		event.rocket_silo.force.print("Detecting drastic increase in enemy activity..." .. biters .. " enemies disturbed")
	end
end)