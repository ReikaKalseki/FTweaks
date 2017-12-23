if Config.woodSludge then

data:extend({
  {
    type = "recipe",
    name = "wood-sludge",
    category = "oil-processing",
    enabled = false,
    energy_required = 4,
    ingredients =
    {
      {type="item", name="wood", amount=20},
      {type="fluid", name="sulfuric-acid", amount=20},
      {type="fluid", name="steam", amount=40}
    },
    results=
    {
      {type="fluid", name="heavy-oil", amount=10},
      {type="fluid", name="light-oil", amount=30},
      --{type="item", name="coal", amount=1}
    },
    icon = "__FTweaks__/graphics/icons/wood-sludge.png",
	icon_size = 32,
    subgroup = "fluid-recipes",
    order = "a[oil-processing]-c[wood-sludge]",
    allow_decomposition = false
  },
  {
    type = "recipe",
    name = "raw-wood-sludge",
    category = "oil-processing",
    enabled = false,
    energy_required = 9,
    ingredients =
    {
      {type="item", name="raw-wood", amount=10},
      {type="fluid", name="sulfuric-acid", amount=25},
      {type="fluid", name="steam", amount=50}
    },
    results=
    {
      {type="fluid", name="heavy-oil", amount=15},
      {type="fluid", name="light-oil", amount=35},
      --{type="item", name="coal", amount=1}
    },
    icon = "__FTweaks__/graphics/icons/raw-wood-sludge.png",
	icon_size = 32,
    subgroup = "fluid-recipes",
    order = "a[oil-processing]-c[raw-wood-sludge]",
    allow_decomposition = false
  },
  {
    type = "technology",
    name = "wood-sludge",
    icon = "__base__/graphics/technology/coal-liquefaction.png",
	icon_size = 128,
    prerequisites = {
		"coal-liquefaction",
		"advanced-material-processing-2",
		"sulfur-processing",
	},
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "wood-sludge"
      },
      {
        type = "unlock-recipe",
        recipe = "raw-wood-sludge"
      }
    },
    unit =
    {
      count = 300,
      ingredients =
      {
        {"science-pack-1", 1},
        {"science-pack-2", 1},
        {"science-pack-3", 1},
        {"production-science-pack", 1}
      },
      time = 30
    },
    order = "d-c"
  },
})

end