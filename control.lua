require "config"

ranTick = false

script.on_load(function()
	
end)

script.on_event(defines.events.on_tick, function(event)
  if not ranTick then
	  game.players[1].force.reset_recipes()
	  game.players[1].force.reset_technologies()
	  game.players[1].color = {r=0.2, g=0.7, b=1.0, a=1.0}
	  ranTick = true
	  --[[
		for chunk in game.surfaces["nauvis"].get_chunks() do
			local x1 = chunk.x*32
			local y1 = chunk.y*32
			local x2 = x1+32
			local y2 = y1+32
			local wells = game.surfaces["nauvis"].find_entities_filtered({area = {{x1, y1}, {x2, y2}}, type = "mining-drill", name="geothermal-well"})
			for _,well in pairs(wells) do
				if well.valid then
					local pos = well.position
					local dir = well.direction
					local f = well.force
					local n = well.name
					well.destroy()
					game.surfaces["nauvis"].create_entity{name=n, position=pos, direction=dir, force=f, fast_replace=true, spill=false}
				end
			end
		end
		--]]
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