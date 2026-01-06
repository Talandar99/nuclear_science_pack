require("__base__.prototypes.entity.pipecovers")
local item_sounds = require("__base__.prototypes.item_sounds")

local hit_effects = require("__base__.prototypes.entity.hit-effects")
local sounds = require("__base__.prototypes.entity.sounds")

data:extend({

	{
		type = "item",
		name = "nuclear-assembling-machine",
		icon = "__nuclear_science_pack__/graphics/nuclear-assembling-machine.png",
		subgroup = "production-machine",
		color_hint = { text = "2" },
		order = "d[nuclear-assembling-machine]",
		inventory_move_sound = item_sounds.mechanical_inventory_move,
		pick_sound = item_sounds.mechanical_inventory_pickup,
		drop_sound = item_sounds.mechanical_inventory_move,
		default_import_location = "nauvis",
		weight = 100 * kg,
		place_result = "nuclear-assembling-machine",
		stack_size = 50,
	},
	{
		type = "recipe",
		name = "nuclear-assembling-machine",
		category = "centrifuging",
		enabled = false,
		ingredients = {
			{ type = "item", name = "steel-plate", amount = 20 },
			{ type = "item", name = "iron-gear-wheel", amount = 25 },
			{ type = "item", name = "processing-unit", amount = 20 },
			{ type = "item", name = "advanced-circuit", amount = 35 },
			{ type = "item", name = "refined-concrete", amount = 20 },
		},
		results = { { type = "item", name = "nuclear-assembling-machine", amount = 1 } },
	},

	{
		type = "assembling-machine",
		name = "nuclear-assembling-machine",
		icon = "__nuclear_science_pack__/graphics/nuclear-assembling-machine.png",
		flags = { "placeable-neutral", "placeable-player", "player-creation" },
		minable = { mining_time = 0.2, result = "nuclear-assembling-machine" },
		max_health = 350,
		corpse = "assembling-machine-3-remnants",
		dying_explosion = "assembling-machine-3-explosion",
		icon_draw_specification = { shift = { 0, -0.3 } },
		circuit_wire_max_distance = assembling_machine_circuit_wire_max_distance,
		circuit_connector = circuit_connector_definitions["assembling-machine"],
		alert_icon_shift = util.by_pixel(0, -12),
		resistances = {
			{
				type = "fire",
				percent = 70,
			},
		},
		fluid_boxes = {
			{
				production_type = "input",
				pipe_picture = assembler3pipepictures(),
				pipe_covers = pipecoverspictures(),
				volume = 1000,
				pipe_connections = {
					{ flow_direction = "input", direction = defines.direction.north, position = { 0, -1 } },
				},
				secondary_draw_orders = { north = -1 },
			},
			{
				production_type = "output",
				pipe_picture = assembler3pipepictures(),
				pipe_covers = pipecoverspictures(),
				volume = 1000,
				pipe_connections = {
					{ flow_direction = "output", direction = defines.direction.south, position = { 0, 1 } },
				},
				secondary_draw_orders = { north = -1 },
			},
		},
		fluid_boxes_off_when_no_fluid_recipe = true,
		collision_box = { { -1.2, -1.2 }, { 1.2, 1.2 } },
		selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } },
		damaged_trigger_effect = hit_effects.entity(),
		fast_replaceable_group = "assembling-machine",
		graphics_set = {
			animation = {
				layers = {
					{
						filename = "__nuclear_science_pack__/graphics/nuclear-assembling-machine/nuclear-assembling-machine.png",
						priority = "high",
						width = 214,
						height = 218,
						frame_count = 32,
						line_length = 8,
						shift = util.by_pixel(0, 4),
						scale = 0.5,
					},
					{
						filename = "__base__/graphics/entity/assembling-machine-2/assembling-machine-2-shadow.png",
						priority = "high",
						width = 196,
						height = 163,
						frame_count = 32,
						line_length = 8,
						draw_as_shadow = true,
						shift = util.by_pixel(12, 4.75),
						scale = 0.5,
					},
				},
			},
		},
		open_sound = sounds.machine_open,
		close_sound = sounds.machine_close,
		impact_category = "metal",
		working_sound = {
			sound = {
				filename = "__base__/sound/assembling-machine-t2-1.ogg",
				volume = 0.45,
				audible_distance_modifier = 0.5,
			},
			fade_in_ticks = 4,
			fade_out_ticks = 20,
		},
		crafting_categories = {
			"basic-crafting",
			"crafting",
			"advanced-crafting",
			"crafting-with-fluid",
			"electronics",
			"electronics-with-fluid",
			"pressing",
			"metallurgy-or-assembling",
			"organic-or-hand-crafting",
			"organic-or-assembling",
			"electronics-or-assembling",
			"cryogenics-or-assembling",
			"crafting-with-fluid-or-metallurgy",
		},
		crafting_speed = 1.5,
		energy_source = {
			type = "burner",
			fuel_categories = { "nuclear" },
			effectivity = 1,
			fuel_inventory_size = 1,
			burnt_inventory_size = 1,
			light_flicker = {
				color = { 0, 0, 0 },
				minimum_intensity = 0.7,
				maximum_intensity = 0.95,
			},
			emissions_per_minute = { pollution = 1 }, --12 is burner drill ,10 is electric drill
		},
		energy_usage = "1MW",
		module_slots = 6,
		allowed_effects = { "consumption", "speed", "productivity", "pollution", "quality" },
	},
})
data:extend({
	{
		type = "technology",
		name = "nuclear-automation",
		icon = "__nuclear_science_pack__/graphics/nuclear-automation.png",
		icon_size = 256,
		effects = {
			{ type = "unlock-recipe", recipe = "nuclear-assembling-machine" },
		},
		prerequisites = {
			"production-science-pack",
			"nuclear-power",
			"space-science-pack",
		},
		unit = {
			count = 3000,
			ingredients = {
				{ "automation-science-pack", 1 },
				{ "logistic-science-pack", 1 },
				{ "chemical-science-pack", 1 },
				{ "space-science-pack", 1 },
				{ "production-science-pack", 1 },
				{ "nuclear-science-pack", 1 },
			},
			time = 60,
		},
	},
})
