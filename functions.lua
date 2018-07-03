require "config"

function increaseStackSize(name, amt)
	local item = data.raw.item[name]
	if not item then
		item = data.raw.tool[name]
	end
	item.stack_size = math.max(item.stack_size, amt)
end

function parseIngredient(entry)
	local type = entry.name and entry.name or entry[1]
	local amt = entry.amount and entry.amount or entry[2]
	return {type, amt}
end

local function changeIngredientInList(list, item, repl, ratio)
	for i = 1,#list do
		local ing = list[i]
		if ing[1] == item then
			ing[1] = repl
			ing[2] = math.ceil(ing[2]*ratio)
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
	
	local prev = rec1.expensive and rec1.expensive.result or rec1.result
	
	if rec1.ingredients and rec2.ingredients then
		list = buildRecipeDifference(from, to, rec1.ingredients, rec2.ingredients)
	end
	
	if rec1.expensive or rec2.expensive then
		local exp1 = rec1.expensive and rec1.expensive.ingredients or rec1.ingredients
		local exp2 = rec2.expensive and rec2.expensive.ingredients or rec2.ingredients
		exp = buildRecipeDifference(from, to, exp1, exp2)
	end
	
	if rec1.normal or rec2.normal then
		local norm1 = rec1.normal and rec1.normal.ingredients or rec1.ingredients
		local norm2 = rec2.normal and rec2.normal.ingredients or rec2.ingredients
		norm = buildRecipeDifference(from, to, norm1, norm2)
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
	if ret.normal then
		ret.normal.ingredients = norm
	end
	if ret.expensive then
		ret.expensive.ingredients = norm
	end
	
	if data.raw.item["basic-circuit-board"] then
		replaceItemInRecipe(ret, "electronic-circuit", "basic-circuit-board", 1)
	end
	
	if register then
		data:extend({ret})
		
		if tech then
			table.insert(data.raw.technology[tech].effects, {type = "unlock-recipe", recipe = name})
		end
	end
	
	return ret
end