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

if Config.collectorEquipment then
  data:extend({
  {
    type = "night-vision-equipment",
    name = "item-collection-equipment",
    sprite =
    {
      filename = "__FTweaks__/graphics/icons/collector-equipment.png",
      width = 64,
      height = 64,
      priority = "medium"
    },
    shape =
    {
      width = 2,
      height = 2,
      type = "full"
    },
    energy_source =
    {
      type = "electric",
      buffer_capacity = "30kJ",
      input_flow_limit = "180kW",
      usage_priority = "secondary-input"
    },
    energy_input = "5kW",
    categories = {"armor"},
    activate_sound = { filename = "__FTweaks__/sounds/itemcollector-on.ogg", volume = 0.5 },
    deactivate_sound = { filename = "__FTweaks__/sounds/itemcollector-off.ogg", volume = 0.5 },
    darkness_to_turn_on = 1,
    color_lookup = {{0.5, "__core__/graphics/color_luts/nightvision.png"}}
  },
  {
    type = "item",
    name = "item-collection-equipment",
    icon = "__FTweaks__/graphics/icons/collector-equipment.png",
    icon_size = 64, icon_mipmaps = 0,
    placed_as_equipment_result = "item-collection-equipment",
    subgroup = "equipment",
    order = "f[item-collection]-a[item-collection-equipment]",
    default_request_amount = 1,
    stack_size = 5
  },
  {
    type = "recipe",
    name = "item-collection-equipment",
    enabled = false,
    energy_required = 20,
    ingredients =
    {
      {"radar", 1},
      {"beacon", 4},
      {"logistic-chest-requester", 2},
      {"personal-roboport-equipment", 1},
    },
    result = "item-collection-equipment"
  },
  {
    type = "technology",
    name = "item-collection-equipment",
    icon_size = 64,
    icon = "__FTweaks__/graphics/icons/collector-equipment.png",
    prerequisites = {"solar-panel-equipment"},
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "item-collection-equipment"
      }
    },
    unit =
    {
      count = 50,
      ingredients = {{"automation-science-pack", 1}, {"logistic-science-pack", 1}, {"chemical-science-pack", 1}},
      time = 20,
    },
    order = "g-g-g"
  }
  })
end