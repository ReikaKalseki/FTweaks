ranTick = false

script.on_load(function()
	
end)

script.on_event(defines.events.on_tick, function(event)
  if not ranTick then
	  game.players[1].force.reset_recipes()
	  game.players[1].force.reset_technologies()
	  game.players[1].color = {r=0.2, g=0.7, b=1.0, a=1.0}
	  ranTick = true
  end
end)