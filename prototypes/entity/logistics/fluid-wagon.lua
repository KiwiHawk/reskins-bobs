-- Copyright (c) 2024 Kirazy
-- Part of Artisanal Reskins: Bob's Mods
--
-- See LICENSE in the project directory for license information.

-- Check to see if reskinning needs to be done.
if not (reskins.bobs and reskins.bobs.triggers.logistics.entities) then return end
if reskins.lib.settings.get_value("bobmods-logistics-trains") == false then return end

-- Set input parameters
local inputs = {
    type = "fluid-wagon",
    icon_name = "fluid-wagon",
    base_entity_name = "fluid-wagon",
    mod = "bobs",
    group = "logistics",
    particles = { ["small"] = 3 },
}

local tier_map = {
    ["fluid-wagon"] = { tier = 1, prog_tier = 2 },
    ["bob-fluid-wagon-2"] = { tier = 2, prog_tier = 3 },
    ["bob-fluid-wagon-3"] = { tier = 3, prog_tier = 4 },
    ["bob-armoured-fluid-wagon"] = { tier = 1, prog_tier = 4 },
    ["bob-armoured-fluid-wagon-2"] = { tier = 2, prog_tier = 5 },
}

-- Reskin entities, create and assign extra details
for name, map in pairs(tier_map) do
    -- Fetch entity
    local entity = data.raw[inputs.type][name]

    -- Check if entity exists, if not, skip this iteration
    if not entity then goto continue end

    -- Parse map
    local tier = map.tier
    if reskins.lib.settings.get_value("reskins-lib-tier-mapping") == "progression-map" then
        tier = map.prog_tier or map.tier
    end

    -- Determine what tint we're using
    inputs.tint = reskins.lib.tiers.get_tint(tier)

    -- Setup icon details
    if string.find(name, "armoured") then
        inputs.icon_extras = reskins.lib.icons.get_symbol("shield", inputs.tint)
    else
        inputs.icon_extras = nil
    end

    reskins.lib.setup_standard_entity(name, tier, inputs)

    -- TODO: Reskin remnants?

    -- TODO: Reskin entity?

    -- Label to skip to next iteration
    ::continue::
end
