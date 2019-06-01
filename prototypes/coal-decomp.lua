if Config.coalSludge and data.raw.item.carbon and data.raw.fluid.hydrogen and data.raw.item["sodium-hydroxide"] and data.raw.technology["chemical-processing-2"] then

local ing = {
	{type = "item", name = "coal", amount = 4},
	{type = "fluid", name = "water", amount = 150},
	{type = "item", name = "sodium-hydroxide", amount = 5}
}

local prod = {
	{type = "item", name = "sulfur", amount = 1},
	{type = "item", name = "carbon", amount = 3},
	{type = "fluid", name = "hydrogen", amount = 40}
}

local pre = {
	"chemical-processing-2",
	"sulfur-processing",
}

if data.raw.fluid["hydrogen-peroxide"] then
	table.insert(ing, {type = "fluid", name = "hydrogen-peroxide", amount = 20})
	--table.insert(pre, "hydrazine")
	table.insert(data.raw.technology["chemical-processing-2"].effects, {type = "unlock-recipe", recipe = "hydrogen-peroxide"})
end
--[[
if data.raw.fluid["waste"] then
	table.insert(prod, {type = "fluid", name = "waste", amount = 90})
	table.insert(pre, "pollution-capture")
end
--]]
data:extend({
  {
    type = "recipe",
    name = "coal-sludge",
    category = "chemistry",
    enabled = false,
    energy_required = 6,
    ingredients = ing,
    results = prod,
    icon = "__FTweaks__/graphics/icons/coal-sludge.png",
	icon_size = 32,
    subgroup = "fluid-recipes",
    order = "a[oil-processing]-c[coal-sludge]",
    allow_decomposition = false
  },
  {
    type = "technology",
    name = "coal-sludge",
    icon = "__base__/graphics/technology/coal-liquefaction.png",
	icon_size = 128,
    prerequisites = pre,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "coal-sludge"
      },
    },
    unit =
    {
      count = 150,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
      },
      time = 30
    },
    order = "d-c"
  },
})

end