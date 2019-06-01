data:extend(
{
--bigger hotbar
  {
    type = "technology",
    name = "toolbelt-4",
    icon = "__base__/graphics/technology/toolbelt.png",
    effects =
    {
      {
        type = "num-quick-bars",
        modifier = 1
      }
    },
    prerequisites = {"toolbelt-3"},
    unit =
    {
      count = 250,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"alien-science-pack", 1},
      },
      time = 45
    },
    upgrade = "true",
    order = "c-k-m-b"
  },
    {
    type = "technology",
    name = "toolbelt-5",
    icon = "__base__/graphics/technology/toolbelt.png",
    effects =
    {
      {
        type = "num-quick-bars",
        modifier = 1
      }
    },
    prerequisites = {"toolbelt-4"},
    unit =
    {
      count = 500,
      ingredients =
      {
        {"automation-science-pack", 4},
        {"logistic-science-pack", 2},
        {"chemical-science-pack", 1},
        {"alien-science-pack", 1},
      },
      time = 60
    },
    upgrade = "true",
    order = "c-k-m-b"
  },
  
  --inserter stack size
  --[[
    {
    type = "technology",
    name = "inserter-stack-size-bonus-5",
    icon = "__base__/graphics/technology/inserter-capacity.png",
    effects =
    {
      {
        type = "inserter-stack-size-bonus",
        modifier = 1
      }
    },
    prerequisites = {"inserter-stack-size-bonus-4"},
    unit =
    {
      count = 400,
      ingredients =
      {
        {"automation-science-pack", 2},
        {"logistic-science-pack", 2},
        {"chemical-science-pack", 2},
        {"alien-science-pack", 2}
      },
      time = 30
    },
    upgrade = true,
    order = "c-o-d"
  },
    {
    type = "technology",
    name = "inserter-stack-size-bonus-6",
    icon = "__base__/graphics/technology/inserter-capacity.png",
    effects =
    {
      {
        type = "inserter-stack-size-bonus",
        modifier = 2
      }
    },
    prerequisites = {"inserter-stack-size-bonus-5"},
    unit =
    {
      count = 800,
      ingredients =
      {
        {"automation-science-pack", 4},
        {"logistic-science-pack", 4},
        {"chemical-science-pack", 2},
        {"alien-science-pack", 2}
      },
      time = 45
    },
    upgrade = true,
    order = "c-o-d"
  },
    {
    type = "technology",
    name = "inserter-stack-size-bonus-7",
    icon = "__base__/graphics/technology/inserter-capacity.png",
    effects =
    {
      {
        type = "inserter-stack-size-bonus",
        modifier = 2
      }
    },
    prerequisites = {"inserter-stack-size-bonus-6"},
    unit =
    {
      count = 1200,
      ingredients =
      {
        {"automation-science-pack", 4},
        {"logistic-science-pack", 4},
        {"chemical-science-pack", 4},
        {"alien-science-pack", 4}
      },
      time = 60
    },
    upgrade = true,
    order = "c-o-d"
  },--]]
}
)

