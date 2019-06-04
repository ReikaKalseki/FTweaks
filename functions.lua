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