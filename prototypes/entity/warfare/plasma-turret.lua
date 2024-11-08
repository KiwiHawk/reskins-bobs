-- Copyright (c) 2024 Kirazy
-- Part of Artisanal Reskins: Bob's Mods
--
-- See LICENSE in the project directory for license information.

-- Check to see if reskinning needs to be done.
if not (reskins.bobs and reskins.bobs.triggers.warfare.entities) then return end

local inputs = {
    type = "electric-turret",
    icon_name = "plasma-turret",
    base_entity_name = "artillery-turret",
    mod = "bobs",
    group = "warfare",
    particles = { ["big"] = 4 },
    make_remnants = false,
}

local tier_map = {
    ["bob-plasma-turret-1"] = { tier = 1 },
    ["bob-plasma-turret-2"] = { tier = 2 },
    ["bob-plasma-turret-3"] = { tier = 3 },
    ["bob-plasma-turret-4"] = { tier = 4 },
    ["bob-plasma-turret-5"] = { tier = 5 },
}

-- Sea Block 0.5.5 recalibrates turret 1 and 2 to tiers 3 and 4, and hides the rest
if reskins.lib.version.is_same_or_newer(mods["SeaBlock"], "0.5.5") then
    tier_map["bob-plasma-turret-1"].prog_tier = 3
    tier_map["bob-plasma-turret-2"].prog_tier = 4
end


local raising_frame_sequence = { 1, 2, 2, 2, 3, 4, 4, 4, 1, 2, 2, 2, 3, 4, 4, 4 }

local function plasma_turret_extension_base(parameters)
    return
    {
        filename = "__reskins-bobs__/graphics/entity/warfare/plasma-turret/hr-plasma-turret-cannon-raising-base.png",
        priority = "medium",
        width = 176,
        height = 178,
        frame_count = 1,
        line_length = 1,
        repeat_count = parameters.repeat_count or 16,
        axially_symmetrical = false,
        direction_count = 8,
        shift = util.by_pixel(-0.5, -35),
        scale = 0.5
    }
end

local function plasma_turret_extension_runtime_mask(parameters)
    return
    {
        filename = "__reskins-bobs__/graphics/entity/warfare/plasma-turret/hr-plasma-turret-cannon-raising-runtime-mask.png",
        priority = "medium",
        width = 176,
        height = 178,
        frame_count = 1,
        line_length = 1,
        repeat_count = parameters.repeat_count or 16,
        axially_symmetrical = false,
        direction_count = 8,
        shift = util.by_pixel(-0.5, -35),
        apply_runtime_tint = true,
        scale = 0.5
    }
end

local function plasma_turret_extension_tint_mask(parameters)
    return
    {
        filename = "__reskins-bobs__/graphics/entity/warfare/plasma-turret/hr-plasma-turret-cannon-raising-mask.png",
        priority = "medium",
        width = 176,
        height = 178,
        frame_count = 1,
        line_length = 1,
        repeat_count = parameters.repeat_count or 16,
        axially_symmetrical = false,
        direction_count = 8,
        shift = util.by_pixel(-0.5, -35),
        tint = parameters.tint,
        scale = 0.5
    }
end

local function plasma_turret_extension_highlights(parameters)
    return
    {
        filename = "__reskins-bobs__/graphics/entity/warfare/plasma-turret/hr-plasma-turret-cannon-raising-highlights.png",
        priority = "medium",
        width = 176,
        height = 178,
        frame_count = 1,
        line_length = 1,
        repeat_count = parameters.repeat_count or 16,
        axially_symmetrical = false,
        direction_count = 8,
        shift = util.by_pixel(-0.5, -35),
        blend_mode = reskins.lib.settings.blend_mode, -- "additive",
        scale = 0.5
    }
end

local function plasma_turret_extension_lights(parameters)
    local shift = util.by_pixel(0, -35)

    return
    {
        filename = "__reskins-bobs__/graphics/entity/warfare/plasma-turret/hr-plasma-turret-cannon-raising-lights-mask.png",
        priority = "medium",
        width = 134,
        height = 178,
        frame_count = 4,
        line_length = 4,
        frame_sequence = raising_frame_sequence,
        run_mode = parameters.run_mode or "forward",
        tint = parameters.tint,
        axially_symmetrical = false,
        direction_count = 8,
        shift = shift,
        draw_as_glow = true,
        scale = 0.5
    }
end

local function plasma_turret_extension_lights_highlights(parameters)
    local shift = util.by_pixel(0, -35)

    return
    {
        filename = "__reskins-bobs__/graphics/entity/warfare/plasma-turret/hr-plasma-turret-cannon-raising-lights-highlights.png",
        priority = "medium",
        width = 134,
        height = 178,
        frame_count = 4,
        line_length = 4,
        frame_sequence = raising_frame_sequence,
        run_mode = parameters.run_mode or "forward",
        blend_mode = "additive",
        axially_symmetrical = false,
        direction_count = 8,
        shift = shift,
        draw_as_glow = true,
        scale = 0.5
    }
end

-- Reskin entities, create and assign extra details
for name, map in pairs(tier_map) do
    -- Fetch entity
    local entity = data.raw[inputs.type][name]


    -- Check if entity exists, if not, skip this iteration
    if not entity then goto continue end

    -- Handle tier
    local tier = map.tier
    if reskins.lib.settings.get_value("reskins-lib-tier-mapping") == "progression-map" then
        tier = map.prog_tier or map.tier
    end

    -- Determine what tint we're using
    inputs.tint = reskins.lib.tiers.get_tint(tier)

    reskins.lib.setup_standard_entity(name, tier, inputs)

    -- Reskin entity
    entity.corpse = "big-remnants"
    entity.base_picture_render_layer = "lower-object-above-shadow"
    entity.base_picture = {
        layers = {
            -- Base
            {
                filename = "__reskins-bobs__/graphics/entity/warfare/plasma-turret/hr-plasma-turret-base.png",
                priority = "high",
                width = 208,
                height = 178,
                shift = util.by_pixel(0, 0),
                scale = 0.5
            },
            -- Runtime Mask
            {
                filename = "__reskins-bobs__/graphics/entity/warfare/plasma-turret/hr-plasma-turret-runtime-mask.png",
                priority = "high",
                width = 208,
                height = 178,
                shift = util.by_pixel(0, 0),
                apply_runtime_tint = true,
                scale = 0.5
            },
            -- Shadow
            {
                filename = "__reskins-bobs__/graphics/entity/warfare/plasma-turret/hr-plasma-turret-base-shadow.png",
                priority = "high",
                width = 244,
                height = 150,
                shift = util.by_pixel(18.5, 11),
                draw_as_shadow = true,
                scale = 0.5
            },
        }
    }

    entity.folded_animation = {
        layers = {
            plasma_turret_extension_base({ repeat_count = 1 }),
            plasma_turret_extension_runtime_mask({ repeat_count = 1 }),
            plasma_turret_extension_tint_mask({ tint = inputs.tint, repeat_count = 1 }),
            plasma_turret_extension_highlights({ repeat_count = 1 }),
        }
    }

    entity.preparing_animation = {
        layers = {
            plasma_turret_extension_base({}),
            plasma_turret_extension_runtime_mask({}),
            plasma_turret_extension_tint_mask({ tint = inputs.tint }),
            plasma_turret_extension_highlights({}),
            plasma_turret_extension_lights({ tint = inputs.tint }),
            plasma_turret_extension_lights_highlights({}),
            plasma_turret_extension_lights({ tint = inputs.tint }),
            plasma_turret_extension_lights_highlights({}),
        }
    }

    entity.prepared_animation = {
        layers = {
            -- Base
            {
                filename = "__reskins-bobs__/graphics/entity/warfare/plasma-turret/hr-plasma-turret-cannon-shooting-base.png",
                line_length = 8,
                width = 176,
                height = 178,
                frame_count = 1,
                direction_count = 64,
                shift = util.by_pixel(-0.5, -35),
                scale = 0.5
            },
            -- Runtime Mask
            {
                filename = "__reskins-bobs__/graphics/entity/warfare/plasma-turret/hr-plasma-turret-cannon-shooting-runtime-mask.png",
                line_length = 8,
                width = 176,
                height = 178,
                frame_count = 1,
                direction_count = 64,
                shift = util.by_pixel(-0.5, -35),
                apply_runtime_tint = true,
                scale = 0.5
            },
            -- Mask
            {
                filename = "__reskins-bobs__/graphics/entity/warfare/plasma-turret/hr-plasma-turret-cannon-shooting-mask.png",
                line_length = 8,
                width = 176,
                height = 178,
                frame_count = 1,
                direction_count = 64,
                shift = util.by_pixel(-0.5, -35),
                tint = inputs.tint,
                scale = 0.5
            },
            -- Highlights
            {
                filename = "__reskins-bobs__/graphics/entity/warfare/plasma-turret/hr-plasma-turret-cannon-shooting-highlights.png",
                line_length = 8,
                width = 176,
                height = 178,
                frame_count = 1,
                direction_count = 64,
                shift = util.by_pixel(-0.5, -35),
                blend_mode = reskins.lib.settings.blend_mode, -- "additive",
                scale = 0.5
            },
            -- Light Mask
            {
                filename = "__reskins-bobs__/graphics/entity/warfare/plasma-turret/hr-plasma-turret-cannon-shooting-light-mask.png",
                line_length = 8,
                width = 176,
                height = 178,
                frame_count = 1,
                direction_count = 64,
                shift = util.by_pixel(-0.5, -35),
                draw_as_glow = true,
                tint = inputs.tint,
                scale = 0.5
            },
            -- Light Highlights
            {
                filename = "__reskins-bobs__/graphics/entity/warfare/plasma-turret/hr-plasma-turret-cannon-shooting-light-highlights.png",
                line_length = 8,
                width = 176,
                height = 178,
                frame_count = 1,
                direction_count = 64,
                shift = util.by_pixel(-0.5, -35),
                draw_as_glow = true,
                blend_mode = reskins.lib.settings.blend_mode, -- "additive",
                scale = 0.5
            },
        }
    }

    entity.folding_animation = {
        layers = {
            plasma_turret_extension_base({}),
            plasma_turret_extension_runtime_mask({}),
            plasma_turret_extension_tint_mask({ tint = inputs.tint }),
            plasma_turret_extension_highlights({}),
            plasma_turret_extension_lights({ run_mode = "backward", tint = inputs.tint }),
            plasma_turret_extension_lights_highlights({ run_mode = "backward" }),
            plasma_turret_extension_lights({ run_mode = "backward", tint = inputs.tint }),
            plasma_turret_extension_lights_highlights({ run_mode = "backward" })
        }
    }

    -- Adjust drawing box
    entity.drawing_box = { { -1.5, -2.5 }, { 1.5, 1.5 } }

    entity.water_reflection = {
        pictures = {
            filename = "__reskins-bobs__/graphics/entity/warfare/plasma-turret/plasma-turret-reflection.png",
            priority = "extra-high",
            width = 28,
            height = 29,
            shift = util.by_pixel(0, 65),
            variation_count = 1,
            scale = 5,
        },
        rotate = false,
        orientation_to_variation = false
    }

    -- Label to skip to next iteration
    ::continue::
end
