require "config"

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

local function listHasValue(list, val)
	for _,entry in pairs(list) do
		if entry == val then return true end
	end
end

function splitTech(tech, prereqs, recipesToMove)
	local base = data.raw.technology[tech]
	local tech2 = table.deepcopy(base)
	local a, b = string.find(tech, "-", 1, true)
	local number = b and tonumber(string.sub(tech, b+1)) or nil
	--error("Number " .. number .. " from " .. tech)
	tech2.name = number and (tech .. "-" .. (number+1)) or (tech .. "-2")
	--log(tech2.name .. " from " .. tech)
	tech2.prerequisites = prereqs
	table.insert(prereqs, tech)
	tech2.effects = {}
	for _,recipe in pairs(recipesToMove) do
		table.insert(tech2.effects, {type = "unlock-recipe", recipe = recipe})
	end
	--for k,v in pairs(recipesToMove) do log(v) end
	local keep = {}
	for _,effect in pairs(base.effects) do
		--log("Checking if list has " .. effect.recipe)
		if effect.type == "unlock-recipe" and listHasValue(recipesToMove, effect.recipe) then
			
		else
			table.insert(keep, effect)
		end
	end
	base.effects = keep
	data:extend({tech2})
end

local function getPrereqTechForPack(pack) --this is going to change in 0.17 to a dedicated tech for each
	if pack == "science-pack-2" then
		return "chemical-processing-2"
	elseif pack == "science-pack-3" then
		return "advanced-electronics"
	elseif pack == "military-science-pack" then
		return "military-2"
	elseif pack == "logistic-science-pack" then
		return "logistics-3"
	elseif pack == "high-tech-science-pack" then
		return "advanced-electronics-2"
	elseif pack == "production-science-pack" then
		return "advanced-material-processing-2"
	elseif pack == "space-science-pack" then
		return "rocket-silo"
	end
end

function addSciencePackToTech(techname, pack)
	local tech = data.raw.technology[techname]
	if not tech then return end
	local prereq = getPrereqTechForPack(pack)
	if prereq and data.raw.technology[prereq] then
		table.insert(tech.prerequisites, prereq)
	end
	table.insert(tech.unit.ingredients, {pack, 1})
end

function replaceTechPrereq(tech, old, new)
	local repl = {}
	local flag = false
	for _,prereq in pairs (data.raw.technology[tech].prerequisites) do
		if prereq == old then
			table.insert(repl, new)
			flag = true
		else
			table.insert(repl, prereq)
		end
	end
	data.raw.technology[tech].prerequisites = repl
	return flag
end

function turnRecipeIntoConversion(from, to)
	local tgt = data.raw.recipe[to]
	if not tgt then return end
	local rec = createConversionRecipe(from, to, false)
	tgt.ingredients = rec.ingredients
	if tgt.normal then tgt.normal.ingredients = rec.normal.ingredients end
	if tgt.expensive then tgt.expensive.ingredients = rec.expensive.ingredients end
end

function parseIngredient(entry)
	local type = entry.name and entry.name or entry[1]
	local amt = entry.amount and entry.amount or entry[2]
	return {type, amt}
end

local function changeIngredientInList(list, item, repl, ratio)
	for i = 1,#list do
		local ing = parseIngredient(list[i])
		--[[
		if ing[1] then
			log("Pos " .. i .. ": " .. ing[1] .. " x" .. ing[2] .. " for " .. item .. "->" .. repl)
		else
			log("Pos " .. i .. " is invalid!")
		end--]]
		--log("Comparing '" .. ing[1] .. "' and '" .. item .. "': " .. (ing[1] == item and "true" or "false"))
		if ing[1] == item then
			ing[1] = repl
			ing[2] = math.ceil(ing[2]*ratio)
			ing.name = repl
			ing.amount = ing[2]
			list[i] = ing
			break
		end
	end
end

function replaceItemInRecipe(recipe, item, repl, ratio)
	if not recipe then error(serpent.block("No such recipe found!")) end
	if recipe.ingredients then
		changeIngredientInList(recipe.ingredients, item, repl, ratio)
	end
	if recipe.normal and recipe.normal.ingredients then
		changeIngredientInList(recipe.normal.ingredients, item, repl, ratio)
	end
	if recipe.expensive and recipe.expensive.ingredients then
		changeIngredientInList(recipe.expensive.ingredients, item, repl, ratio)
	end
end

function moveRecipe(recipe, from, to)
	local tech = data.raw.technology[from]
	local effects = {}
	for _,effect in pairs(tech.effects) do
		if effect.type == "unlock-recipe" and effect.recipe == recipe then
		
		else
			table.insert(effects, effect)
		end
	end
	tech.effects = effects
	table.insert(data.raw.technology[to].effects, {type = "unlock-recipe", recipe = recipe})
end

--returns nil if none, not {}
local function buildRecipeSurplus(name1, name2, list1, list2)
	local counts = {}
	local ret = nil
	for i = 1,#list1 do
		local ing = parseIngredient(list1[i])
		--log("Parsing input ingredient: " .. (ing[1] and ing[1] or "nil") .. " x " .. (ing[2] and ing[2] or "nil"))
		if #ing > 0 then
			--log(#ing .. " > " .. tostring(ing))
			counts[ing[1]] = (counts[ing[1]] and counts[ing[1]] or 0)+(ing[2] and ing[2] or 1) -- += in case recipe specifies an ingredient multiple times
		else
			log("Found empty entry in recipe " .. name1 .. "!")
		end
	end
	for i = 1,#list2 do
		local ing = parseIngredient(list2[i])
		--log("Parsing output ingredient: " .. (ing[1] and ing[1] or "nil") .. " x " .. (ing[2] and ing[2] or "nil"))
		if #ing > 0 then
			if counts[ing[1]] then
				counts[ing[1]] = counts[ing[1]]-ing[2]
			end
		else
			log("Found empty entry in recipe " .. name2 .. "!")
		end
	end
	for item,amt in pairs(counts) do
		if counts[item] > 0 and data.raw.item[item] then
			if not ret then ret = {} end
			ret[item] = amt
		end
	end
	return ret
end

local function buildRecipeDifference(name1, name2, list1, list2)
	local counts = {}
	local ret = {}
	for i = 1,#list1 do
		local ing = parseIngredient(list1[i])
		--log("Parsing input ingredient: " .. (ing[1] and ing[1] or "nil") .. " x " .. (ing[2] and ing[2] or "nil"))
		if #ing > 0 then
			--log(#ing .. " > " .. tostring(ing))
			counts[ing[1]] = (counts[ing[1]] and counts[ing[1]] or 0)+(ing[2] and ing[2] or 1) -- += in case recipe specifies an ingredient multiple times
		else
			log("Found empty entry in recipe " .. name1 .. "!")
		end
	end
	for i = 1,#list2 do
		local ing = parseIngredient(list2[i])
		--log("Parsing output ingredient: " .. (ing[1] and ing[1] or "nil") .. " x " .. (ing[2] and ing[2] or "nil"))
		if #ing > 0 then
			local amt = ing[2]-(counts[ing[1]] and counts[ing[1]] or 0)
			if amt > 0 then
				ret[#ret+1] = {ing[1], amt}
			end
		else
			log("Found empty entry in recipe " .. name2 .. "!")
		end
	end
	return ret
end

function createConversionRecipe(from, to, register, tech)
	local rec1 = data.raw.recipe[from]
	local rec2 = data.raw.recipe[to]
	
	if not rec1 then
		error("No such recipe '" .. from .. "'!")
	end
	if not rec2 then
		error("No such recipe '" .. to .. "'!")
	end
	
	local name = rec1.name .. "-conversion-to-" .. rec2.name
	
	if data.raw.recipe.name then
		error("Conversion recipe already exists: " .. name)
	else
		log("Creating conversion recipe " .. name)
	end
	
	local list = nil
	local exp = nil
	local norm = nil
	
	local e_list = nil
	local e_exp = nil
	local e_norm = nil
	
	local prev = rec1.expensive and rec1.expensive.result or rec1.result
	
	if rec1.ingredients and rec2.ingredients then
		list = buildRecipeDifference(from, to, rec1.ingredients, rec2.ingredients)
		e_list = buildRecipeSurplus(from, to, rec1.ingredients, rec2.ingredients)
	end
	
	if rec1.expensive or rec2.expensive then
		local exp1 = rec1.expensive and rec1.expensive.ingredients or rec1.ingredients
		local exp2 = rec2.expensive and rec2.expensive.ingredients or rec2.ingredients
		exp = buildRecipeDifference(from, to, exp1, exp2)
		e_exp = buildRecipeSurplus(from, to, exp1, exp2)
	end
	
	if rec1.normal or rec2.normal then
		local norm1 = rec1.normal and rec1.normal.ingredients or rec1.ingredients
		local norm2 = rec2.normal and rec2.normal.ingredients or rec2.ingredients
		norm = buildRecipeDifference(from, to, norm1, norm2)
		e_norm = buildRecipeSurplus(from, to, norm1, norm2)
	end
	
	if list then
		table.insert(list, {prev, rec1.result_count and rec1.result_count or 1})
	end
	if exp then
		table.insert(exp, {prev, rec1.expensive.result_count and rec1.expensive.result_count or 1})
	end
	if norm then
		table.insert(norm, {prev, rec1.normal.result_count and rec1.normal.result_count or 1})
	end
	
	local ret = table.deepcopy(rec2)
	ret.name = name
	ret.ingredients = list
	local main = rec1.result and rec1.result or rec1.normal.result
	local result = rec2.result and rec2.result or rec2.normal.result
	ret.localised_name = {"conversion-recipe.name", {"entity-name." .. main}, {"entity-name." .. result}}
	local orig_icon_src = rec2
	if not (orig_icon_src.icon or orig_icon_src.icons) then
		orig_icon_src = data.raw.item[result]
	end
	if not (orig_icon_src.icon or orig_icon_src.icons) then
		error("Could not find an icon for " .. rec2.name .. ", in either the recipe or its produced item! This item is invalid and would have crashed the game anyways!")
	end
	local ico = orig_icon_src.icon and orig_icon_src.icon or orig_icon_src.icons[1].icon
	local icosz = orig_icon_src.icon_size and orig_icon_src.icon_size or orig_icon_src.icons[1].icon_size
	ret.icons = {{icon = ico, icon_size = icosz}, {icon = "__FTweaks__/graphics/icons/conversion_overlay.png", icon_size = 32}}
	if not ret.icon then
		if data.raw.item[result] then
			ret.icon = data.raw.item[result].icon
		else
			log("Could not create icon for conversion recipe '" .. name .. "'! No such item '" .. result .. "'")
		end
	end
	if e_list then
		ret.results = {{type = "item", name = ret.result, amount = ret.result_count and ret.result_count or 1}}
		for type,count in pairs(e_list) do
			table.insert(ret.results, {type = "item", name = type, amount = count})
		end
		ret.result = nil
		ret.subgroup = data.raw.item[result].subgroup
	end
	if ret.normal then
		ret.normal.ingredients = norm
		if e_norm then
			ret.normal.results = {{type = "item", name = ret.normal.result, amount = ret.normal.result_count and ret.normal.result_count or 1}}
			for type,count in pairs(e_norm) do
				table.insert(ret.normal.results, {type = "item", name = type, amount = count})
			end
			ret.normal.result = nil
			ret.subgroup = data.raw.item[result].subgroup
		end
	end
	if ret.expensive then
		ret.expensive.ingredients = exp
		if e_exp then
			ret.expensive.results = {{type = "item", name = ret.expensive.result, amount = ret.expensive.result_count and ret.expensive.result_count or 1}}
			for type,count in pairs(e_exp) do
				table.insert(ret.expensive.results, {type = "item", name = type, amount = count})
			end
			ret.expensive.result = nil
			ret.subgroup = data.raw.item[result].subgroup
		end
	end
	
	if data.raw.item["basic-circuit-board"] then
		replaceItemInRecipe(ret, "electronic-circuit", "basic-circuit-board", 1)
	end
	
	ret.allow_decomposition = false
	ret.allow_as_intermediate = false
	
	if register then
		data:extend({ret})
		
		if tech then
			table.insert(data.raw.technology[tech].effects, {type = "unlock-recipe", recipe = name})
		end
	end
	
	return ret
end