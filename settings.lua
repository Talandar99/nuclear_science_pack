data:extend({
	{
		type = "bool-setting",
		name = "nuclear-assembling-machine",
		setting_type = "startup",
		default_value = true,
		order = "nuclear-science-pack-a",
	},
	{
		type = "bool-setting",
		name = "refillable-fission-reactor-equipment",
		setting_type = "startup",
		default_value = true,
		order = "nuclear-science-pack-b",
	},
	{
		type = "bool-setting",
		name = "nuclear-science-pack-centrifuge-prod-bonus",
		setting_type = "startup",
		default_value = true,
		order = "nuclear-science-pack-z",
	},
})

if mods["Cerys-Moon-of-Fulgora"] then
	data:extend({
		{
			type = "bool-setting",
			name = "refillable-mixed-oxide-reactor-equipment",
			setting_type = "startup",
			default_value = true,
			order = "nuclear-science-pack-c",
		},
		{
			type = "bool-setting",
			name = "lock-nuclear-science-pack-behind-cerys",
			setting_type = "startup",
			default_value = true,
			order = "nuclear-science-pack-d",
		},
	})
end

if mods["Cerys-Moon-of-Fulgora"] then
	local function force_setting(setting_type, setting_name, value)
		local setting = data.raw[setting_type .. "-setting"][setting_name]
		if setting then
			if setting_type == "bool" then
				setting.forced_value = value
			else
				setting.allowed_values = { value }
			end
			setting.default_value = value
			setting.hidden = true
		end
	end
	force_setting("bool", "cerys-radiative-heaters-require-cryogenic-science", false)
end
