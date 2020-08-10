require "config"

require "__DragonIndustries__.mathhelper"
require "__DragonIndustries__.arrays"
require "__DragonIndustries__.tech"
require "__DragonIndustries__.recipe"

function reduceTechnologyCost(tech, factorAmount)
	if type(tech) == "string" then tech = data.raw.technology[tech] end
	if not tech then error(serpent.block("No such technology found! " .. debug.traceback())) end
	if not tech.unit.count and not tech.unit.count_formula then error("Tech " .. tech.name .. " has no science pack cost!") end
	local f = factorAmount > 1 and (1+((Config.techFactor-1)/factorAmount)) or Config.techFactor/factorAmount
	if tech.unit.count then
		local new = math.max(1, math.ceil(tech.unit.count/f))
		if new > 5 then
			new = math.max(1, 5*math.floor(new/5+0.5)) --round to nearest 5
		end
		--multiply since those ones are the "effective" costs:
		log("Adjusted cost of technology '" .. tech.name .. "'; for a tech cost factor of " .. Config.techFactor .. "x, comultiplied through " .. factorAmount .. " to " .. f .. "x: Count changed from " .. tech.unit.count*Config.techFactor .. " to " .. new*Config.techFactor)
		tech.unit.count = new
	elseif tech.unit.count_formula then
		tech.unit.count_formula = tech.unit.count_formula .. "*" .. (1/f)
		log("Adjusted cost of technology '" .. tech.name .. "'; for a tech cost factor of " .. Config.techFactor .. "x, comultiplied through " .. factorAmount .. " to " .. f .. "x: Formula is now " .. tech.unit.count_formula)
	end
end

function improveAttribute(object, param, newval)
	object[param] = math.max(object[param], newval)
end

function increaseStackSize(name, amt)
	local item = data.raw.item[name]
	if not item then
		item = data.raw.tool[name]
	end
	item.stack_size = math.max(item.stack_size, amt)
end

local function shouldCollectItem(entity)
	return entity.to_be_deconstructed() or entity.stack.name == "biter-flesh"
end

function tickCollectorEquipment(player)
	if player.valid and player.character.grid and player.character.grid.valid then
		local items = player.character.grid.get_contents()
		if items and items["item-collection-equipment"] and player.character.grid.available_in_batteries > 0 then
			local inv = player.character.get_inventory(defines.inventory.character_main)
			local r = 40
			local box = {{player.position.x-r, player.position.y-r}, {player.position.x+r, player.position.y+r}}
			local items = player.surface.find_entities_filtered{name = "item-on-ground", area = box, force = {player.force, game.forces.neutral}}
			for _,e in pairs(items) do
				if e.stack and e.stack.valid_for_read and shouldCollectItem(e) and inv.can_insert(e.stack) then
					inv.insert(e.stack)
					e.destroy()
				end
			end
		end
	end
end