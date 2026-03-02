if settings.startup["nuclear-assembling-machine"].value then
	local base_categories = data.raw["assembling-machine"]["assembling-machine-3"].crafting_categories
	data.raw["assembling-machine"]["nuclear-assembling-machine"].crafting_categories = base_categories
end

-- acceleration
data.raw.item["uranium-fuel-cell"].fuel_acceleration_multiplier =
	data.raw.item["nuclear-fuel"].fuel_acceleration_multiplier
-- top speed
data.raw.item["uranium-fuel-cell"].fuel_top_speed_multiplier = data.raw.item["nuclear-fuel"].fuel_top_speed_multiplier
-- quality acceleration
data.raw.item["uranium-fuel-cell"].fuel_acceleration_multiplier_quality_bonus =
	data.raw.item["nuclear-fuel"].fuel_acceleration_multiplier_quality_bonus
-- quality top speed
data.raw.item["uranium-fuel-cell"].fuel_top_speed_multiplier_quality_bonus =
	data.raw.item["nuclear-fuel"].fuel_top_speed_multiplier_quality_bonus

if mods["Cerys-Moon-of-Fulgora"] then
	data.raw.item["mixed-oxide-fuel-cell"].fuel_acceleration_multiplier = data.raw.item["nuclear-fuel"].fuel_acceleration_multiplier
		+ 1
	data.raw.item["mixed-oxide-fuel-cell"].fuel_top_speed_multiplier = data.raw.item["nuclear-fuel"].fuel_top_speed_multiplier
		+ 0.5
	data.raw.item["mixed-oxide-fuel-cell"].fuel_acceleration_multiplier_quality_bonus =
		data.raw.item["nuclear-fuel"].fuel_acceleration_multiplier_quality_bonus
	data.raw.item["mixed-oxide-fuel-cell"].fuel_top_speed_multiplier_quality_bonus =
		data.raw.item["nuclear-fuel"].fuel_top_speed_multiplier_quality_bonus
end

if mods["maraxsis"] then
	local sub = data.raw["spider-vehicle"] and data.raw["spider-vehicle"]["maraxsis-nuclear-submarine"]
	if sub and sub.energy_source and sub.energy_source.fuel_categories then
		local cats = sub.energy_source.fuel_categories or {}
		local found = false

		for _, c in pairs(cats) do
			if c == "nuclear-mixed-oxide" then
				found = true
				break
			end
		end

		if not found then
			table.insert(cats, "nuclear-mixed-oxide")
		end
	end
end
