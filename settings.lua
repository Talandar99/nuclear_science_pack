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
