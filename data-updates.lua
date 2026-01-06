if settings.startup["nuclear-assembling-machine"].value then
	local base_categories = data.raw["assembling-machine"]["assembling-machine-3"].crafting_categories
	data.raw["assembling-machine"]["nuclear-assembling-machine"].crafting_categories = base_categories
end
