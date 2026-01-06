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
})

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
