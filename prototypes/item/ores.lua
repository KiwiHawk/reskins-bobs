-- Copyright (c) 2024 Kirazy
-- Part of Artisanal Reskins: Bob's Mods
--
-- See LICENSE in the project directory for license information.

-- Check to see if reskinning needs to be done.
if not (reskins.bobs and reskins.bobs.triggers.ores.items) then
	return
end

---@type CreateIconsFromListInputs
local inputs = {
	mod = "bobs",
	group = "ores",
	make_icon_pictures = false,
	flat_icon = true,
}

---@type CreateIconsFromListTable
local intermediates = {}

-- Items and recipes shared with other mods within Bob's suite
if not mods["bobplates"] then
	-- Intermediates
	intermediates["lithia-water"] = { type = "fluid", group = "plates", subgroup = "fluids", defer_to_data_updates = true } -- Angels
end

reskins.internal.create_icons_from_list(intermediates, inputs)
