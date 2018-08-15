require "config"

--require("prototypes.research")

require "prototypes.wood-sludge"

data:extend(
{
  {
    type = "recipe-category",
    name = "manual-crafting"
  },
  {
    type = "recipe-category", --not advanced-crafting, which restricts to blue or better assemblers
    name = "non-manual-crafting"
  },
})