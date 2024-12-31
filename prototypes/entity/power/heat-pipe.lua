-- Copyright (c) 2024 Kirazy
-- Part of Artisanal Reskins: Bob's Mods
--
-- See LICENSE in the project directory for license information.

-- Check to see if reskinning needs to be done.
if not (reskins.bobs and reskins.bobs.triggers.power.entities) then return end

-- Set input parameters
local inputs = {
    type = "heat-pipe",
    base_entity_name = "heat-pipe",
    mod = "bobs",
}

local tier_map = {
    ["heat-pipe"] = { tier = 1, prog_tier = 2, material = "base" },
    ["heat-pipe-2"] = { tier = 2, prog_tier = 3, material = "silver-aluminum", particle_colors = { "d4d4d4", "dff5ff" } },
    ["heat-pipe-3"] = { tier = 3, prog_tier = 5, material = "gold-copper", particle_colors = { "d6b968", "ff7f3f" } },
}

if reskins.lib.version.is_same_or_newer(mods["bobpower"], "1.1.6") then
    tier_map["heat-pipe-2"].material = "aluminum-invar"
    tier_map["heat-pipe-3"].particle_colors = { "dff5ff", "a99b84" }

    tier_map["heat-pipe-3"].prog_tier = 4
    tier_map["heat-pipe-3"].material = "silver-titanium"
    tier_map["heat-pipe-3"].particle_colors = { "d4d4d4", "cfd2d4" }

    tier_map["heat-pipe-4"] = {
        tier = 4,
        prog_tier = 5,
        material = "gold-copper",
        particle_colors = { "d6b968", "ff7f3f" },
    }
end

-- Reskin entities, create and assign extra details
for name, mapping in pairs(tier_map) do
    ---@type data.HeatPipePrototype
    local entity = data.raw[inputs.type][name]

    -- Check if entity exists, if not, skip this iteration
    if not entity then goto continue end

    -- Parse map
    local tier = mapping.tier
    if reskins.lib.settings.get_value("reskins-lib-tier-mapping") == "progression-map" then
        tier = mapping.prog_tier or mapping.tier
    end

    -- Setup inputs defaults
    reskins.lib.set_inputs_defaults(inputs)

    -- Setup icons
    ---@type data.IconData[]
    local icon_data = { {
        icon = "__reskins-bobs__/graphics/icons/power/heat-pipe/heat-pipe-" .. mapping.material .. "-icon-base.png",
        icon_size = 64,
        scale = 0.5,
    } }

    local do_labels = reskins.lib.settings.get_value("reskins-bobs-do-pipe-tier-labeling") == true

    ---@type DeferrableIconData
    local deferrable_icon = {
        name = name,
        type_name = "heat-pipe",
        icon_data = do_labels and reskins.lib.tiers.add_tier_labels_to_icons(tier, icon_data) or icon_data,
        pictures = do_labels and reskins.lib.sprites.create_sprite_from_icons(icon_data, 1.0) or nil,
    }

    reskins.lib.icons.assign_deferrable_icon(deferrable_icon)

    --- Don't reskin the base pipes
    if name == "heat-pipe" then goto continue end

    -- Create particles and explosions
    reskins.lib.create_explosion(name, inputs)
    reskins.lib.create_particle(name, inputs.base_entity_name, reskins.lib.particle_index["small"], 1, util.color(mapping.particle_colors[1]))
    reskins.lib.create_particle(name, inputs.base_entity_name, reskins.lib.particle_index["medium"], 2, util.color(mapping.particle_colors[2]))

    -- Create and skin remnants
    reskins.lib.create_remnant(name, inputs)
    local remnant = data.raw["corpse"][name .. "-remnants"]
    remnant.animation = make_rotated_animation_variations_from_sheet(6, {
        filename = "__reskins-bobs__/graphics/entity/power/heat-pipe/" .. mapping.material .. "/remnants/heat-pipe-remnants.png",
        line_length = 1,
        width = 122,
        height = 100,
        frame_count = 1,
        direction_count = 2,
        shift = util.by_pixel(0.5, -1.5),
        scale = 0.5,
    })

    -- Reskin entities
    entity.connection_sprites = make_heat_pipe_pictures("__reskins-bobs__/graphics/entity/power/heat-pipe/" .. mapping.material .. "/", "heat-pipe",
        {
            single = { name = "straight-vertical-single", ommit_number = true },
            straight_vertical = { variations = 6 },
            straight_horizontal = { variations = 6 },
            corner_right_up = { name = "corner-up-right", variations = 6 },
            corner_left_up = { name = "corner-up-left", variations = 6 },
            corner_right_down = { name = "corner-down-right", variations = 6 },
            corner_left_down = { name = "corner-down-left", variations = 6 },
            t_up = {},
            t_down = {},
            t_right = {},
            t_left = {},
            cross = { name = "t" },
            ending_up = {},
            ending_down = {},
            ending_right = {},
            ending_left = {},
        })

    -- Label to skip to next iteration
    ::continue::
end
