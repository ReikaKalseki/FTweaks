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
        {"science-pack-1", 1},
        {"science-pack-2", 1},
        {"science-pack-3", 1},
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
        {"science-pack-1", 4},
        {"science-pack-2", 2},
        {"science-pack-3", 1},
        {"alien-science-pack", 1},
      },
      time = 60
    },
    upgrade = "true",
    order = "c-k-m-b"
  },
  
  --inserter stack size
    {
    type = "technology",
    name = "inserter-stack-size-bonus-5",
    icon = "__base__/graphics/technology/inserter-stack-size-bonus.png",
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
        {"science-pack-1", 2},
        {"science-pack-2", 2},
        {"science-pack-3", 2},
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
    icon = "__base__/graphics/technology/inserter-stack-size-bonus.png",
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
        {"science-pack-1", 4},
        {"science-pack-2", 4},
        {"science-pack-3", 2},
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
    icon = "__base__/graphics/technology/inserter-stack-size-bonus.png",
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
        {"science-pack-1", 4},
        {"science-pack-2", 4},
        {"science-pack-3", 4},
        {"alien-science-pack", 4}
      },
      time = 60
    },
    upgrade = true,
    order = "c-o-d"
  },
}
)

