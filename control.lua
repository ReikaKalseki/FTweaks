require "config"

function initGlobal(force)
	if not global.ftweaks then
		global.ftweaks = {}
	end
	if force or global.ftweaks.ranTick == nil then
		global.ftweaks.ranTick = false
	end
end

local function doOneTick()
	for _,force in pairs(game.forces) do
		force.reset_recipes()
		force.reset_technologies()
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

local strees = {}

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
end)

script.on_event(defines.events.on_player_joined_game, function(event)
	if game.players and #game.players > 0 and game.players[event.player_index].name == "Reika" then
		game.players[event.player_index].color = {r=0.2, g=0.7, b=1.0, a=1.0}
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