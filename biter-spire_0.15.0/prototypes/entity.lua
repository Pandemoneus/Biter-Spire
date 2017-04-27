data:extend({
{
    type = "electric-energy-interface",
    name = "biter-spire",
    icon = "__biter-spire__/graphics/biter_spire_icon.png",
    flags = {"placeable-neutral", "not-repairable", "not-blueprintable", "not-deconstructable"},
    corpse = "medium-remnants",
    max_health = 1000,
    collision_box = {{-0.9, -0.9}, {0.9, 0.9}},
    selection_box = {{-1, -1}, {1, 1}},
    drawing_box = {{-1, -3}, {1, 1}},
    enable_gui = true,
    energy_source =
    {
      type = "electric",
      buffer_capacity = "0J",
      usage_priority = "primary-output",
      output_flow_limit = "0W"
    },
    energy_production = "0W",
    energy_usage = "0W",
    -- also 'pictures' for 4-way sprite is available, or 'animation' resp. 'animations'
    picture =
    {
      filename = "__biter-spire__/graphics/biter_spire_neutral.png",
      priority = "extra-high",
      width = 128,
      height = 128,
      shift = {1, -1}
    },
    animation =
    {
      filename = "__biter-spire__/graphics/biter_spire_load.png",
      width = 128,
      height = 128,
      shift = {1, -1},
      line_length = 1,
      frame_count = 1,
      animation_speed = 0.5,
    },
    charge_light = {intensity = 0.3, size = 7, color = {r = 1.0, g = 1.0, b = 1.0}},
    discharge_animation =
    {
      filename = "__biter-spire__/graphics/biter_spire_unload.png",
      width = 128,
      height = 128,
      shift = {1, -1},
      line_length = 1,
      frame_count = 1,
      animation_speed = 1,
    },
    discharge_light = {intensity = 0.7, size = 7, color = {r = 1.0, g = 1.0, b = 1.0}},
    vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
    working_sound =
    {
      sound =
      {
        filename = "__base__/sound/accumulator-working.ogg",
        volume = 1
      },
      idle_sound = {
        filename = "__base__/sound/accumulator-idle.ogg",
        volume = 0.4
      },
      max_sounds_per_type = 5
    },
}
})