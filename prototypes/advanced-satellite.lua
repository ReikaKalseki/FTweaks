require "functions"

if Config.advancedSatellite then

local recipe = table.deepcopy(data.raw.recipe.satellite)
local ingredients = {}
for _,ingredient in pairs(recipe.ingredients) do
	ingredient = parseIngredient(table.deepcopy(ingredient))
	log("Parsing ingredient: " .. (ingredient[1] and ingredient[1] or "nil") .. " x " .. (ingredient[2] and ingredient[2] or "nil"))
	if ingredient[1] == "plutonium" then
		ingredient[2] = 10
	end
	if ingredient[1] == "processing-unit" then
		ingredient[1] = "advanced-circuit"
	end
	if string.find(ingredient[1], "accumulator") or string.find(ingredient[1], "solar-panel", 1, true) then
		ingredient[2] = ingredient[2]*2
	end
	if ingredient[1] == "radar" or ingredient[1] == "rocket-fuel" or ingredient[1] == "low-density-structure" then
		ingredient[2] = 0
	end
	if ingredient[2] > 0 then
		table.insert(ingredients, ingredient)
	end
end

recipe.ingredients = ingredients
table.insert(recipe.ingredients, {"satellite", 2})
recipe.name = "advanced-satellite"
recipe.result = "advanced-satellite"
recipe.energy_required = recipe.energy_required*4

local item = table.deepcopy(data.raw.item.satellite)
item.name = "advanced-satellite"
item.rocket_launch_product[2] = 5000 --instead of 1k

-- this line is 0.15 code; above is for 0.16 -- table.insert(data.raw["rocket-silo-rocket"]["rocket-silo-rocket"].result_items, {"space-science-pack", 5000, "advanced-satellite"})
increaseStackSize("space-science-pack", 5000)

data:extend({
  recipe, item,
  
  {
    type = "technology",
    name = "advanced-satellite",
    icon = "__base__/graphics/technology/rocket-silo.png",
    prerequisites = {
		"rocket-silo",
	},
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "advanced-satellite"
      },
    },
    unit =
    {
      count = 1000,
      ingredients =
      {
        {"science-pack-1", 1},
        {"science-pack-2", 1},
        {"science-pack-3", 1},
        {"production-science-pack", 1},
        {"high-tech-science-pack", 1},
        {"space-science-pack", 1},
      },
      time = 30
    },
    icon_size = 128,
    order = "d-c"
  },
})

end