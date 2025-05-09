-- Copyright (c) 2024 Kirazy
-- Part of Artisanal Reskins: Bob's Mods
--
-- See LICENSE in the project directory for license information.

-- Check to see if reskinning needs to be done.
if not (reskins.bobs and reskins.bobs.triggers.equipment.equipment) then
	return
end

-- Note that for equipment, the icons property is not used, so omit type information
-- so that an icon is not set on the equipment prototype.
local inputs = {
	icon_name = "fission-reactor",
	mod = "bobs",
	group = "equipment",
}

-- Setup defaults
reskins.lib.set_inputs_defaults(inputs)

local fission_reactors = {
	["fission-reactor-equipment"] = { tier = 1, prog_tier = 3 },
	["bob-fission-reactor-equipment-2"] = { tier = 2, prog_tier = 4 },
	["bob-fission-reactor-equipment-3"] = { tier = 3, prog_tier = 5 },
	["bob-fission-reactor-equipment-4"] = { tier = 4, prog_tier = 6 },
}

-- Reskin equipment
for name, map in pairs(fission_reactors) do
	-- Fetch equipment
	local equipment = data.raw["generator-equipment"][name]
	if not equipment then
		goto continue
	end

	local tier = reskins.lib.tiers.get_tier(map)
	inputs.tint = reskins.lib.tiers.get_tint(tier)

	-- Construct icon
	reskins.lib.construct_icon(name, tier, inputs)

	-- Reskin the equipment
	equipment.sprite = {
		layers = {
			-- Base
			{
				filename = "__reskins-bobs__/graphics/equipment/equipment/fission-reactor/fission-reactor-equipment-base.png",
				size = 256,
				priority = "medium",
				flags = { "no-crop" },
				scale = 0.5,
			},
			-- Mask
			{
				filename = "__reskins-bobs__/graphics/equipment/equipment/fission-reactor/fission-reactor-equipment-mask.png",
				size = 256,
				priority = "medium",
				flags = { "no-crop" },
				tint = inputs.tint,
				scale = 0.5,
			},
			-- Highlights
			{
				filename = "__reskins-bobs__/graphics/equipment/equipment/fission-reactor/fission-reactor-equipment-highlights.png",
				size = 256,
				priority = "medium",
				flags = { "no-crop" },
				blend_mode = reskins.lib.settings.blend_mode, -- "additive",
				scale = 0.5,
			},
		},
	}

	::continue::
end
