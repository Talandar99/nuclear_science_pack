local space_age_item_sounds = require("__space-age__.prototypes.item_sounds")
local item_effects = require("__space-age__.prototypes.item-effects")
local item_tints = require("__base__.prototypes.item-tints")
local item_sounds = require("__base__.prototypes.item_sounds")
local sounds = require("__base__.prototypes.entity.sounds")

local function add_prerequisite_if_missing(tech_name, prerequisite_name)
	local tech = data.raw.technology[tech_name]
	if not tech then
		return
	end

	tech.prerequisites = tech.prerequisites or {}

	for _, p in pairs(tech.prerequisites) do
		if p == prerequisite_name then
			return -- już istnieje, nic nie robimy
		end
	end

	table.insert(tech.prerequisites, prerequisite_name)
end
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
		pictures = {
			layers = {
				{
					filename = "__nuclear_science_pack__/graphics/nuclear-science-pack.png",
					mipmap_count = 4,
					scale = 0.5,
					size = 64,
				},
				{
					filename = "__nuclear_science_pack__/graphics/nuclear-science-pack-glow.png",
					mipmap_count = 4,
					scale = 0.5,
					size = 64,
					draw_as_light = true,
				},
			},
		},
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
add_centrifuging_recipe("centrifuge")
add_centrifuging_recipe("atomic-bomb")
data.raw["assembling-machine"]["centrifuge"].module_slots = 4

if settings.startup["nuclear-science-pack-centrifuge-prod-bonus"].value then
	data.raw["assembling-machine"]["centrifuge"].effect_receiver = { base_effect = { productivity = 0.5 } }
end
data.raw["item"]["centrifuge"].weight = 200 * kg

if mods["Cerys-Moon-of-Fulgora"] then
	--table.insert(data.raw.technology["cerys-applications-of-radioactivity"].prerequisites, "fission-reactor-equipment")
	data.raw.technology["moon-discovery-cerys"].prerequisites = { "planet-discovery-fulgora" }
	add_science_pack_and_kovarex_prerequisite("cerys-radiative-heaters")

	add_science_pack_and_kovarex_prerequisite("cerys-mixed-oxide-reactors")
	add_prerequisite_if_missing("cerys-mixed-oxide-reactors", "nuclear-power")
	add_prerequisite_if_missing("fusion-reactor", "cerys-mixed-oxide-reactors")

	add_science_pack_and_kovarex_prerequisite("cerys-applications-of-radioactivity")
	add_prerequisite_if_missing("cerys-applications-of-radioactivity", "fission-reactor-equipment")
	add_prerequisite_if_missing("fusion-reactor-equipment", "cerys-applications-of-radioactivity")

	if settings.startup["lock-nuclear-science-pack-behind-cerys"].value then
		add_prerequisite_if_missing("uranium-mining", "cerys-plutonium-weaponry")
		add_prerequisite_if_missing("uranium-processing", "cerys-plutonium-weaponry")
		add_prerequisite_if_missing("kovarex-enrichment-process", "cerys-plutonium-weaponry")
	end

	if settings.startup["refillable-mixed-oxide-reactor-equipment"].value then
		data.raw["generator-equipment"]["mixed-oxide-reactor-equipment"].burner = {
			type = "burner",
			fuel_categories = { "nuclear-mixed-oxide" },
			fuel_inventory_size = 1,
			burnt_inventory_size = 1,
		}
		data.raw["generator-equipment"]["mixed-oxide-reactor-equipment"].power = "1.8MW"
	end
end

if settings.startup["nuclear-assembling-machine"].value then
	require("nuclear-assembling-machine")
end
if settings.startup["refillable-fission-reactor-equipment"].value then
	data.raw["generator-equipment"]["fission-reactor-equipment"].burner = {
		type = "burner",
		fuel_categories = { "nuclear" },
		fuel_inventory_size = 1,
		burnt_inventory_size = 1,
	}
	data.raw["generator-equipment"]["fission-reactor-equipment"].power = "1.5MW"
end
data.raw["technology"]["kovarex-enrichment-process"].icon =
	"__nuclear_science_pack__/graphics/nuclear-science-pack-technology.png"

data.raw["technology"]["kovarex-enrichment-process"].localised_name = { "technology-name.nuclear-science-pack" }
