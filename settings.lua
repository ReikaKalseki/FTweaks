data:extend({
        {
            type = "bool-setting",
            name = "bigger-stacks",
            setting_type = "startup",
            default_value = true,
            order = "r",
			localised_name = "Bigger material stack sizes",
			localised_description = "If true, raw materials (ore, plates, etc) stack to 200.",
        },
        {
            type = "bool-setting",
            name = "cheap-steel",
            setting_type = "startup",
            default_value = true,
            order = "r",
			localised_name = "Cheaper steel",
			localised_description = "Bobplates-style; reduces cost to 2 iron per steel and halves smelt time.",
        },
        {
            type = "bool-setting",
            name = "harder-silo",
            setting_type = "startup",
            default_value = true,
            order = "r",
			localised_name = "Harder silo",
			localised_description = "Makes the rocket silo much harder, both in terms of research and resources.",
        },
        {
            type = "bool-setting",
            name = "harder-nuclear",
            setting_type = "startup",
            default_value = true,
            order = "r",
			localised_name = "Harder reactors",
			localised_description = "Greatly increases the technology progression required to research nuclear reactors.",
        },
})
