-- Copyright (c) 2024 Kirazy
-- Part of Artisanal Reskins: Bob's Mods
--
-- See LICENSE in the project directory for license information.

-- Check to see if reskinning needs to be done.
if not (reskins.bobs and reskins.bobs.triggers.electronics.technologies) then return end

---@type CreateIconsFromListInputs
local inputs = {
    mod = "bobs",
    group = "electronics",
    type = "technology",
    technology_icon_size = 256,
    flat_icon = true,
}

---@type CreateIconsFromListTable
local technologies = {
    ["advanced-electronics-2"] = {technology_icon_filename = "__base__/graphics/technology/electronics.png"},
}

reskins.internal.create_icons_from_list(technologies, inputs)