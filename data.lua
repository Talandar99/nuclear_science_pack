local space_age_item_sounds = require("__space-age__.prototypes.item_sounds")
local item_effects = require("__space-age__.prototypes.item-effects")
local item_tints = require("__base__.prototypes.item-tints")
local item_sounds = require("__base__.prototypes.item_sounds")
local sounds = require("__base__.prototypes.entity.sounds")
data:extend({
	{
		type = "tool",
		name = "nuclear-science-pack",
		icon = "__nuclear_science_pack__/graphics/nuclear-science-pack.png",
		icon_size = 64,
		subgroup = "science-pack",
		color_hint = { text = "W" },
		order = "i",
		inventory_move_sound = item_sounds.science_inventory_move,
		pick_sound = item_sounds.science_inventory_pickup,
		drop_sound = item_sounds.science_inventory_move,
		stack_size = 200,
		default_import_location = "nauvis",
		weight = 1 * kg,
		durability = 1,
		durability_description_key = "description.science-pack-remaining-amount-key",
		factoriopedia_durability_description_key = "description.factoriopedia-science-pack-remaining-amount-key",
		durability_description_value = "description.science-pack-remaining-amount-value",
		random_tint_color = item_tints.bluish_science,
	},
	{
		type = "recipe",
		name = "nuclear-science-pack",
		subgroup = "science-pack",
		category = "centrifuging",
		surface_conditions = {
			{
				property = "pressure",
				min = 1000,
				max = 1000,
			},
		},
		enabled = false,
		ingredients = {
			{ type = "item", name = "water-barrel", amount = 2 },
			{ type = "item", name = "refined-concrete", amount = 5 },
			{ type = "item", name = "uranium-235", amount = 1 },
		},
		energy_required = 10,
		results = {
			{ type = "item", name = "nuclear-science-pack", amount = 2 },
			{ type = "item", name = "barrel", amount = 2, ignored_by_stats = 2, ignored_by_productivity = 2 },
		},
		main_product = "nuclear-science-pack",
		allow_productivity = true,
	},
})
table.insert(data.raw["lab"]["lab"].inputs, "nuclear-science-pack")
table.insert(data.raw["lab"]["biolab"].inputs, "nuclear-science-pack")

local function add_science_pack_and_kovarex_prerequisite(name)
	-- check if tech exist
	local tech = data.raw.technology[name]
	if not tech then
		return
	end
	-- add science pack
	table.insert(tech.unit.ingredients, { "nuclear-science-pack", 1 })
	-- add kovarex prerequisite only if missing
	for _, p in pairs(tech.prerequisites or {}) do
		if p == "kovarex-enrichment-process" then
			return
		end
	end
	table.insert(tech.prerequisites, "kovarex-enrichment-process")
end
add_science_pack_and_kovarex_prerequisite("biolab")
add_science_pack_and_kovarex_prerequisite("nuclear-power")
add_science_pack_and_kovarex_prerequisite("uranium-ammo")
add_science_pack_and_kovarex_prerequisite("atomic-bomb")
add_science_pack_and_kovarex_prerequisite("captive-biter-spawner")
add_science_pack_and_kovarex_prerequisite("fission-reactor-equipment")
add_science_pack_and_kovarex_prerequisite("nuclear-fuel-reprocessing")
add_science_pack_and_kovarex_prerequisite("spidertron")
add_science_pack_and_kovarex_prerequisite("fusion-reactor-equipment")
add_science_pack_and_kovarex_prerequisite("fusion-reactor")
add_science_pack_and_kovarex_prerequisite("promethium-science-pack")
add_science_pack_and_kovarex_prerequisite("planet-discovery-aquilo")
add_science_pack_and_kovarex_prerequisite("foundation")
add_science_pack_and_kovarex_prerequisite("legendary-quality")

table.insert(data.raw.technology["research-productivity"].unit.ingredients, { "nuclear-science-pack", 1 })

data.raw.technology["kovarex-enrichment-process"].unit = nil
data.raw.technology["kovarex-enrichment-process"].research_trigger = {
	type = "craft-item",
	item = "uranium-235",
	count = 50,
}
table.insert(
	data.raw.technology["kovarex-enrichment-process"].effects,
	{ type = "unlock-recipe", recipe = "nuclear-science-pack" }
)

local function add_centrifuging_recipe(recipe_name)
	if data.raw["recipe"][recipe_name] then
		if not data.raw["recipe"][recipe_name].additional_categories then
			data.raw["recipe"][recipe_name].additional_categories = {}
		end
		table.insert(data.raw["recipe"][recipe_name].additional_categories, "centrifuging")
	end
end
add_centrifuging_recipe("uranium-rounds-magazine")
add_centrifuging_recipe("uranium-fuel-cell")
add_centrifuging_recipe("uranium-cannon-shell")
add_centrifuging_recipe("explosive-uranium-cannon-shell")
add_centrifuging_recipe("fission-reactor-equipment")
add_centrifuging_recipe("spidertron")
add_centrifuging_recipe("nuclear-reactor")
add_centrifuging_recipe("biolab")
add_centrifuging_recipe("fusion-reactor-equipment")
data.raw["assembling-machine"]["centrifuge"].module_slots = 4
data.raw["assembling-machine"]["centrifuge"].effect_receiver = { base_effect = { productivity = 0.5 } }
data.raw["item"]["centrifuge"].weight = 200 * kg

if mods["Cerys-Moon-of-Fulgora"] then
	table.insert(data.raw.technology["kovarex-enrichment-process"].prerequisites, "cerys-plutonium-weaponry")
	table.insert(data.raw.technology["cerys-applications-of-radioactivity"].prerequisites, "fission-reactor-equipment")
	add_science_pack_and_kovarex_prerequisite("cerys-radiative-heaters")
end
-- make lignumis inserter and belt equal to the
--
--if settings.startup["ltdi-wood-and-iron-belts-are-equal"].value then
--	data.raw["transport-belt"]["wood-transport-belt"].speed = data.raw["transport-belt"]["transport-belt"].speed
--	data.raw["underground-belt"]["wood-underground-belt"].speed = data.raw["underground-belt"]["underground-belt"].speed
--	data.raw["splitter"]["wood-splitter"].speed = data.raw["splitter"]["splitter"].speed
--end
---- add progressive recipes but to second tier
--if settings.startup["ltdi-enable-progressive-recipes-for-machines"].value then
--	--------------------------------------------------------------------------------
--	-- machines
--	--------------------------------------------------------------------------------
--	table.insert(
--		data.raw.recipe["assembling-machine-2"].ingredients,
--		{ type = "item", name = "burner-assembling-machine", amount = 1 }
--	)
--	--------------------------------------------------------------------------------
--	-- belts
--	--------------------------------------------------------------------------------
--	table.insert(
--		data.raw.recipe["fast-transport-belt"].ingredients,
--		{ type = "item", name = "wood-transport-belt", amount = 1 }
--	)
--	table.insert(
--		data.raw.recipe["fast-underground-belt"].ingredients,
--		{ type = "item", name = "wood-underground-belt", amount = 2 }
--	)
--	table.insert(data.raw.recipe["fast-splitter"].ingredients, { type = "item", name = "wood-splitter", amount = 1 })
--
--	--------------------------------------------------------------------------------
--	-- inserter
--	--------------------------------------------------------------------------------
--	table.insert(data.raw.recipe["fast-inserter"].ingredients, { type = "item", name = "burner-inserter", amount = 1 })
--	--------------------------------------------------------------------------------
--	-- ammo
--	--------------------------------------------------------------------------------
--	table.insert(
--		data.raw.recipe["piercing-rounds-magazine"].ingredients,
--		{ type = "item", name = "wood-darts-magazine", amount = 1 }
--	)
--	--------------------------------------------------------------------------------
--end
-----
--if settings.startup["ltdi-add-steam-assembling-machine-recipe"].value then
--	data:extend({
--		{
--			type = "recipe",
--			name = "steam-assembling-machine-iron-pipe",
--			icons = {
--				{ icon = "__lignumis-assets__/graphics/icons/steam-assembling-machine.png", icon_size = 64 },
--				{ icon = "__base__/graphics/icons/iron-plate.png", icon_size = 64, scale = 0.25, shift = { 8, 8 } },
--			},
--			enabled = false,
--			ingredients = {
--				{ type = "item", name = "pipe", amount = 5 },
--				{ type = "item", name = "iron-plate", amount = 10 },
--				{ type = "item", name = "iron-gear-wheel", amount = 5 },
--			},
--			results = { { type = "item", name = "steam-assembling-machine", amount = 1 } },
--			allow_productivity = false,
--		},
--	})
--
--	table.insert(
--		data.raw["technology"]["steam-power"].effects,
--		{ type = "unlock-recipe", recipe = "steam-assembling-machine-iron-pipe" }
--	)
--end
