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

for _,e in pairs(data.raw["assembling-machine"]) do
	local recipes = false
	for _,cat in pairs(e.crafting_categories) do
		if cat == "crafting" then
			recipes = true
			break
		end
	end
	table.insert(e.crafting_categories, "non-manual-crafting")
end