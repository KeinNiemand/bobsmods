local function bob_electrolyser_animation_facing(directory, tier, tint, facing)
  return
  {
    layers =
    {
      -- Base
      {
        filename = directory.."/electrolyser-"..tier.."-base.png",
        x = 136 * facing,
        width = 136,
        height = 130,
        frame_count = 1,
        shift = util.by_pixel(17, 0),
        hr_version = 
        {
          filename = directory.."/hr-electrolyser-"..tier.."-base.png",
          x = 272 * facing,
          width = 272,
          height = 260,
          frame_count = 1,
          shift = util.by_pixel(17, 0),
          scale = 0.5
        }
      },
      -- Mask
      {
        filename = directory.."/electrolyser-"..tier.."-mask.png",
        x = 136 * facing,
        width = 136,
        height = 130,
        frame_count = 1,
        shift = util.by_pixel(17, 0),
        tint = tint,
        hr_version = 
        {
          filename = directory.."/hr-electrolyser-"..tier.."-mask.png",
          x = 272 * facing,
          width = 272,
          height = 260,
          frame_count = 1,
          shift = util.by_pixel(17, 0),
          tint = tint,
          scale = 0.5
        }
      },
      -- Highlights
      {
        filename = directory.."/electrolyser-"..tier.."-highlights.png",
        x = 136 * facing,
        width = 136,
        height = 130,
        frame_count = 1,
        shift = util.by_pixel(17, 0),
        blend_mode = "additive",
        hr_version = 
        {
          filename = directory.."/hr-electrolyser-"..tier.."-highlights.png",
          x = 272 * facing,
          width = 272,
          height = 260,
          frame_count = 1,
          shift = util.by_pixel(17, 0),
          blend_mode = "additive",
          scale = 0.5
        }
      },
      -- Shadow
      {
        filename = directory.."/electrolyser-"..tier.."-shadow.png",
        x = 136 * facing,
        width = 136,
        height = 130,
        frame_count = 1,
        shift = util.by_pixel(17, 0),
        draw_as_shadow = true,
        hr_version = 
        {
          filename = directory.."/hr-electrolyser-"..tier.."-shadow.png",
          x = 272 * facing,
          width = 272,
          height = 260,
          frame_count = 1,
          draw_as_shadow = true,
          shift = util.by_pixel(17, 0),
          scale = 0.5
        }
      }
    }
  }
end

local function bob_electrolyser_animation(directory, tier, tint)
return {
  north = bob_electrolyser_animation_facing(directory, tier, tint, 0),
  east = bob_electrolyser_animation_facing(directory, tier, tint, 1),
  south = bob_electrolyser_animation_facing(directory, tier, tint, 2),
  west = bob_electrolyser_animation_facing(directory, tier, tint, 3)
}
end



data:extend(
{
  {
    type = "assembling-machine",
    name = "electrolyser",
    icon = "__bobplates__/graphics/icons/electrolyser.png",
    icon_size = 32,
    flags = {"placeable-neutral","placeable-player", "player-creation"},
    minable = {mining_time = 0.5, result = "electrolyser"},
    fast_replaceable_group = "electrolyser",
    corpse = "big-remnants",
    collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    max_health = 150,
    crafting_categories = {"electrolysis"},
    allowed_effects = {"consumption", "speed", "productivity", "pollution"},
    module_specification =
    {
      module_slots = 1,
    },
    crafting_speed = 0.75,
    energy_usage = "420kW",
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = 4
    },
    fluid_boxes = 
    {
      {
        production_type = "input",
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = -1,
        pipe_connections = {{type = "input", position = {-1, -2}}}
      },
      {
        production_type = "input",
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = -1,
        pipe_connections = {{type = "input", position = {1, -2}}}
      },
      {
        production_type = "output",
        pipe_covers = pipecoverspictures(),
        base_level = 1,
        pipe_connections = {{type = "output", position = {-1, 2}}}
      },
      {
        production_type = "output",
        pipe_covers = pipecoverspictures(),
        base_level = 1,
        pipe_connections = {{type = "output", position = {1, 2}}}
      }
    },
    animation = bob_electrolyser_animation("__bobplates__/graphics/entity/electrolyser", 1, {r = 0.5, g = 0.5, b = 0}),
    working_sound = data.raw["assembling-machine"]["chemical-plant"].working_sound,
  },


  {
    type = "assembling-machine",
    name = "stone-chemical-furnace",
    icon = "__bobplates__/graphics/icons/stone-chemical-furnace.png",
    icon_size = 32,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 0.2, result = "stone-chemical-furnace"},
    max_health = 200,
    crafting_speed = 1,
    corpse = "medium-remnants",
    repair_sound = { filename = "__base__/sound/manual-repair-simple.ogg" },
    mined_sound = { filename = "__base__/sound/deconstruct-bricks.ogg" },
    working_sound =
    {
      sound = { filename = "__base__/sound/furnace.ogg" }
    },
    resistances =
    {
      {
        type = "fire",
        percent = 80
      },
      {
        type = "explosion",
        percent = 30
      }
    },
    fluid_boxes =
    {
      {
        production_type = "input",
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = -1,
        pipe_connections = {{type = "input", position = {0.5, -1.5}}}
      },
    },
    collision_box = {{-0.7, -0.7}, {0.7, 0.7}},
    selection_box = {{-1, -1}, {1, 1}},
    crafting_categories = {"chemical-furnace"},
    energy_usage = "90kW",
    energy_source =
    {
      type = "burner",
      fuel_category = "chemical",
      effectivity = 1,
      fuel_inventory_size = 1,
      emissions_per_minute = 2,
      smoke =
      {
        {
          name = "smoke",
          deviation = {0.1, 0.1},
          frequency = 5,
          north_position = {0.0, -0.8},
          east_position = {0.0, -0.8},
          south_position = {0.0, -0.8},
          west_position = {0.0, -0.8},
          starting_vertical_speed = 0.08,
          starting_frame_deviation = 60
        }
      }
    },
    animation =
    {
      north =
      {
        filename = "__bobplates__/graphics/entity/stone-chemical-furnace/stone-chemical-furnace.png",
        priority = "extra-high",
        width = 94,
        height = 80,
        frame_count = 1,
        shift = {0.25, 0 }
      },
      west =
      {
        filename = "__bobplates__/graphics/entity/stone-chemical-furnace/stone-chemical-furnace.png",
        x = 94,
        priority = "extra-high",
        width = 94,
        height = 80,
        frame_count = 1,
        shift = {0.25, 0 }
      },
      south =
      {
        x = 188,
        filename = "__bobplates__/graphics/entity/stone-chemical-furnace/stone-chemical-furnace.png",
        priority = "extra-high",
        width = 94,
        height = 80,
        frame_count = 1,
        shift = {0.25, 0 }
      },
      east =
      {
        x = 282,
        filename = "__bobplates__/graphics/entity/stone-chemical-furnace/stone-chemical-furnace.png",
        priority = "extra-high",
        width = 94,
        height = 80,
        frame_count = 1,
        shift = {0.25, 0 }
      }
    },
    working_visualisations =
    {
      {
        north_position = { 0.96875, -0.53125},
        west_position = { 0, 0},
        south_position = { -0.9375, 0.40625},
        east_position = { 0.53125, 0.78125},
        east_animation =
        {
          filename = "__bobplates__/graphics/entity/stone-chemical-furnace/boiler-fire-down.png",
          width = 9,
          height = 8,
          frame_count = 14,
        },
        south_animation =
        {
          filename = "__bobplates__/graphics/entity/stone-chemical-furnace/boiler-fire-left.png",
          width = 5,
          height = 7,
          frame_count = 14,
        },
        north_animation =
        {
          filename = "__bobplates__/graphics/entity/stone-chemical-furnace/boiler-fire-right.png",
          width = 6,
          height = 9,
          frame_count = 14,
        }
      },
    },
    fast_replaceable_group = "furnace",
    next_upgrade = "steel-chemical-furnace",
  },

  {
    type = "assembling-machine",
    name = "steel-chemical-furnace",
    icon = "__base__/graphics/icons/steel-furnace.png",
    icon_size = 64,
    icon_mipmaps = 4,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 0.2, result = "steel-chemical-furnace"},
    max_health = 300,
    crafting_speed = 2,
    corpse = "medium-remnants",
    repair_sound = { filename = "__base__/sound/manual-repair-simple.ogg" },
    mined_sound = { filename = "__base__/sound/deconstruct-bricks.ogg" },
    working_sound =
    {
      sound = { filename = "__base__/sound/furnace.ogg" }
    },
    resistances =
    {
      {
        type = "fire",
        percent = 80
      },
      {
        type = "explosion",
        percent = 30
      }
    },
    fluid_boxes =
    {
      {
        production_type = "input",
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = -1,
        pipe_connections = {{type = "input", position = {0.5, -1.5}}}
      },
    },
    collision_box = {{-0.7, -0.7}, {0.7, 0.7}},
    selection_box = {{-1, -1}, {1, 1}},
    crafting_categories = {"chemical-furnace"},
    energy_usage = "90kW",
    energy_source =
    {
      type = "burner",
      fuel_category = "chemical",
      effectivity = 1,
      fuel_inventory_size = 1,
      emissions_per_minute = 4,
      smoke =
      {
        {
          name = "smoke",
          frequency = 10,
          north_position = {0.7, -1.2},
          east_position = {0.7, -1.2},
          south_position = {0.7, -1.2},
          west_position = {0.7, -1.2},
          starting_vertical_speed = 0.08,
          starting_frame_deviation = 60
        }
      }
    },
    animation = util.table.deepcopy(data.raw.furnace["steel-furnace"].animation),
    working_visualisations = util.table.deepcopy(data.raw.furnace["steel-furnace"].working_visualisations),
    fast_replaceable_group = "furnace"
  },

  {
    type = "assembling-machine",
    name = "electric-chemical-furnace",
    icon = "__bobplates__/graphics/icons/chemical-furnace.png",
    icon_size = 32,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 0.2, result = "electric-chemical-furnace"},
    max_health = 350,
    corpse = "big-remnants",
    resistances = 
    {
      {
        type = "fire",
        percent = 80
      }
    },
    fluid_boxes =
    {
      {
        production_type = "input",
        pipe_picture = assembler3pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = -1,
        pipe_connections = {{type = "input", position = {0, -2}}}
      },
      off_when_no_fluid_recipe = true
    },
    collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},

    module_specification =
    {
      module_slots = 3,
      module_info_icon_shift = {0, 0.5},
      module_info_multi_row_initial_height_modifier = -0.3
    },
    crafting_speed = 2,
    crafting_categories = {"smelting", "chemical-furnace"},
    energy_usage = "180kW",
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = 1,
    },
    working_sound =
    {
      sound =
      {
        filename = "__base__/sound/electric-furnace.ogg",
        volume = 0.7
      },
      apparent_volume = 1.5
    },
    animation =
    {
      filename = "__bobplates__/graphics/entity/electric-furnace/electric-chemical-furnace.png",
      priority = "high",
      width = 129,
      height = 100,
      frame_count = 1,
      shift = {0.46875, 0}
    },
    working_visualisations =
    {
      {
        animation =
        {
          filename = "__bobplates__/graphics/entity/electric-furnace/electric-furnace-heater.png",
          priority = "high",
          width = 25,
          height = 15,
          frame_count = 12,
          animation_speed = 0.5,
          shift = {0.015625, 0.890625},
          hr_version =
          {
            filename = "__bobplates__/graphics/entity/electric-furnace/hr-electric-furnace-heater.png",
            priority = "high",
            width = 60,
            height = 56,
            frame_count = 12,
            animation_speed = 0.5,
            shift = util.by_pixel(1.75, 32.75),
            scale = 0.5
          }
        },
        light = {intensity = 0.4, size = 6, shift = {0.0, 1.0}, color = {r = 1.0, g = 1.0, b = 1.0}}
      },
      {
        animation =
        {
          filename = "__bobplates__/graphics/entity/electric-furnace/electric-furnace-propeller-1.png",
          priority = "high",
          width = 19,
          height = 13,
          frame_count = 4,
          animation_speed = 0.5,
          shift = {-0.671875, -0.640625},
          hr_version =
          {
            filename = "__bobplates__/graphics/entity/electric-furnace/hr-electric-furnace-propeller-1.png",
            priority = "high",
            width = 37,
            height = 25,
            frame_count = 4,
            animation_speed = 0.5,
            shift = util.by_pixel(-20.5, -18.5),
            scale = 0.5
          }
        }
      },
    },
    fast_replaceable_group = "furnace",
    allowed_effects = {"consumption", "speed", "productivity", "pollution"},
  },

  {
    type = "assembling-machine",
    name = "stone-mixing-furnace",
    icon = "__bobplates__/graphics/icons/stone-mixing-furnace.png",
    icon_size = 32,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 0.2, result = "stone-mixing-furnace"},
    max_health = 200,
    corpse = "medium-remnants",
    working_sound =
    {
      sound = { filename = "__base__/sound/furnace.ogg" }
    },
    resistances = 
    {
      {
        type = "fire",
        percent = 100
      }
    },
    collision_box = {{-0.7, -0.7}, {0.7, 0.7}},
    selection_box = {{-0.8, -1}, {0.8, 1}},
    crafting_categories = {"smelting", "mixing-furnace"},
    energy_usage = "90kW",
    crafting_speed = 1,
    energy_source =
    {
      type = "burner",
      fuel_category = "chemical",
      effectivity = 1,
      fuel_inventory_size = 1,
      emissions_per_minute = 2,
      smoke =
      {
        {
          name = "smoke",
          deviation = {0.1, 0.1},
          frequency = 5,
          position = {0.0, -0.8},
          starting_vertical_speed = 0.08,
          starting_frame_deviation = 60
        }
      }
    },

    animation =
    {
      filename = "__bobplates__/graphics/entity/stone-mixing-furnace/stone-mixing-furnace.png",
      priority = "extra-high",
      width = 81,
      height = 64,
      frame_count = 1,
      shift = {0.5, 0.05 }
    },
    working_visualisations =
    {
      {
        north_position = { 0.078125, 0.5234375},
        west_position = { 0.078125, 0.5234375},
        south_position = { 0.078125, 0.5234375},
        east_position = { 0.078125, 0.5234375},
        animation =
        {
          filename = "__bobplates__/graphics/entity/stone-mixing-furnace/stone-mixing-furnace-fire.png",
          width = 23,
          height = 27,
          frame_count = 12,
        }
      },
    },
    fast_replaceable_group = "furnace",
    next_upgrade = "steel-mixing-furnace",
  },

  {
    type = "assembling-machine",
    name = "steel-mixing-furnace",
    icon = "__base__/graphics/icons/steel-furnace.png",
    icon_size = 64,
    icon_mipmaps = 4,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 0.2, result = "steel-mixing-furnace"},
    max_health = 300,
    corpse = "medium-remnants",
    working_sound =
    {
      sound = { filename = "__base__/sound/furnace.ogg" }
    },
    resistances = 
    {
      {
        type = "fire",
        percent = 100
      }
    },
    collision_box = {{-0.7, -0.7}, {0.7, 0.7}},
    selection_box = {{-0.8, -1}, {0.8, 1}},
    crafting_categories = {"smelting", "mixing-furnace"},
    energy_usage = "90kW",
    crafting_speed = 2,
    energy_source =
    {
      type = "burner",
      fuel_category = "chemical",
      effectivity = 1,
      fuel_inventory_size = 1,
      emissions_per_minute = 4,
      smoke =
      {
        {
          name = "smoke",
          frequency = 10,
          position = {0.7, -1.2},
          starting_vertical_speed = 0.08,
          starting_frame_deviation = 60
        }
      }
    },
    animation = util.table.deepcopy(data.raw.furnace["steel-furnace"].animation),
    working_visualisations = util.table.deepcopy(data.raw.furnace["steel-furnace"].working_visualisations),
    fast_replaceable_group = "furnace"
  },

  {
    type = "assembling-machine",
    name = "electric-mixing-furnace",
    icon = "__bobplates__/graphics/icons/electric-mixing-furnace.png",
    icon_size = 32,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 1, result = "electric-mixing-furnace"},
    max_health = 350,
    corpse = "big-remnants",
    resistances = 
    {
      {
        type = "fire",
        percent = 80
      }
    },
    collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},

    module_specification =
    {
      module_slots = 3,
      module_info_icon_shift = {0, 0.5},
      module_info_multi_row_initial_height_modifier = -0.3
    },
    crafting_speed = 2,
    crafting_categories = {"smelting", "mixing-furnace"},
    energy_usage = "180kW",

    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = 1,
    },
    working_sound =
    {
      sound =
      {
        filename = "__base__/sound/electric-furnace.ogg",
        volume = 0.7
      },
      apparent_volume = 1.5
    },

    animation =
    {
      layers =
      {
        {
          filename = "__bobplates__/graphics/entity/electric-furnace/electric-mixing-furnace.png",
          priority = "high",
          width = 129,
          height = 100,
          frame_count = 1,
          shift = {0.46875, 0}
        },
        {
          filename = "__bobplates__/graphics/entity/electric-furnace/electric-furnace-mask.png",
          tint = {r = 0.2, g = 0.6, b = 0.8},
          priority = "high",
          width = 69,
          height = 68,
          frame_count = 1,
          shift = util.by_pixel(7.5, 12)
        },
      }
    },
    working_visualisations =
    {
      {
        animation =
        {
          filename = "__bobplates__/graphics/entity/electric-furnace/electric-furnace-heater.png",
          priority = "high",
          width = 25,
          height = 15,
          frame_count = 12,
          animation_speed = 0.5,
          shift = {0.015625, 0.890625},
          hr_version =
          {
            filename = "__bobplates__/graphics/entity/electric-furnace/hr-electric-furnace-heater.png",
            priority = "high",
            width = 60,
            height = 56,
            frame_count = 12,
            animation_speed = 0.5,
            shift = util.by_pixel(1.75, 32.75),
            scale = 0.5
          }
        },
        light = {intensity = 0.4, size = 6, shift = {0.0, 1.0}, color = {r = 1.0, g = 1.0, b = 1.0}}
      },
      {
        animation =
        {
          filename = "__bobplates__/graphics/entity/electric-furnace/electric-furnace-propeller-1.png",
          priority = "high",
          width = 19,
          height = 13,
          frame_count = 4,
          animation_speed = 0.5,
          shift = {-0.671875, -0.640625},
          hr_version =
          {
            filename = "__bobplates__/graphics/entity/electric-furnace/hr-electric-furnace-propeller-1.png",
            priority = "high",
            width = 37,
            height = 25,
            frame_count = 4,
            animation_speed = 0.5,
            shift = util.by_pixel(-20.5, -18.5),
            scale = 0.5
          }
        }
      },
      {
        animation =
        {
          filename = "__bobplates__/graphics/entity/electric-furnace/electric-furnace-propeller-2.png",
          priority = "high",
          width = 12,
          height = 9,
          frame_count = 4,
          animation_speed = 0.5,
          shift = {0.0625, -1.234375},
          hr_version =
          {
            filename = "__bobplates__/graphics/entity/electric-furnace/hr-electric-furnace-propeller-2.png",
            priority = "high",
            width = 23,
            height = 15,
            frame_count = 4,
            animation_speed = 0.5,
            shift = util.by_pixel(3.5, -38),
            scale = 0.5
          }
        }
      }
    },
    fast_replaceable_group = "furnace",
    allowed_effects = {"consumption", "speed", "productivity", "pollution"},
  },
}
)

table.insert(data.raw.furnace["electric-furnace"].animation.layers, 2,
        {
          filename = "__bobplates__/graphics/entity/electric-furnace/electric-furnace-mask.png",
          tint = {r = 0.8, g = 0.8, b = 0.2},
          priority = "high",
          width = 69,
          height = 68,
          frame_count = 1,
          shift = util.by_pixel(7.5, 12)
        }
)


circuit_connector_definitions["bob-small-storage-tank"] = circuit_connector_definitions.create
(
  universal_connector_template,
  {
    { variation = 27, main_offset = util.by_pixel(10, -18), shadow_offset = util.by_pixel(6, -16), show_shadow = false },
    { variation = 25, main_offset = util.by_pixel(-10, -18), shadow_offset = util.by_pixel(-6, -16), show_shadow = false },
    { variation = 27, main_offset = util.by_pixel(10, -18), shadow_offset = util.by_pixel(6, -16), show_shadow = false },
    { variation = 25, main_offset = util.by_pixel(-10, -18), shadow_offset = util.by_pixel(-6, -16), show_shadow = false }
  }
)


data:extend(
{
  {
    type = "storage-tank",
    name = "bob-small-inline-storage-tank",
    icon = "__bobplates__/graphics/icons/small-storage-tank.png",
    icon_size = 32,
    flags = {"placeable-player", "player-creation"},
    minable = {mining_time = 0.2, result = "bob-small-inline-storage-tank"},
    max_health = 200,
    corpse = "small-remnants",
    collision_box = {{-0.3, -0.3}, {0.3, 0.3}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    fluid_box =
    {
      base_area = 25,
      pipe_picture = assembler3pipepictures(),
      pipe_covers = pipecoverspictures(),
      pipe_connections =
      {
        { position = {0, -1} },
        { position = {0,  1} },
      }
    },
    two_direction_only = true,
    fast_replaceable_group = "pipe",
    window_bounding_box = {util.by_pixel(-3, -5), util.by_pixel(3, 11)},
    pictures =
    {
      picture =
      {
        sheets =
        {
          {
            filename = "__bobplates__/graphics/entity/small-storage-tank-w.png",
            priority = "extra-high",
            frames = 2,
            width = 32,
            height = 62,
            shift = util.by_pixel(0, -15),
          },
          {
            filename = "__bobplates__/graphics/entity/small-storage-tank-shadow.png",
            priority = "extra-high",
            frames = 1,
            width = 52,
            height = 32,
            shift = util.by_pixel(30, 0),
            draw_as_shadow = true,
          }
        }
      },
      fluid_background =
      {
        filename = "__base__/graphics/entity/storage-tank/fluid-background.png",
        priority = "extra-high",
        width = 32,
        height = 15
      },
      window_background =
      {
        filename = "__base__/graphics/entity/storage-tank/window-background.png",
        priority = "extra-high",
        width = 17,
        height = 24,
        hr_version =
        {
          filename = "__base__/graphics/entity/storage-tank/hr-window-background.png",
          priority = "extra-high",
          width = 34,
          height = 48,
          scale = 0.5
        }
      },
      flow_sprite =
      {
        filename = "__base__/graphics/entity/pipe/fluid-flow-low-temperature.png",
        priority = "extra-high",
        width = 160,
        height = 20
      },
      gas_flow =
      {
        filename = "__base__/graphics/entity/pipe/steam.png",
        priority = "extra-high",
        line_length = 10,
        width = 24,
        height = 15,
        frame_count = 60,
        axially_symmetrical = false,
        direction_count = 1,
        animation_speed = 0.25,
        hr_version =
        {
          filename = "__base__/graphics/entity/pipe/hr-steam.png",
          priority = "extra-high",
          line_length = 10,
          width = 48,
          height = 30,
          frame_count = 60,
          axially_symmetrical = false,
          animation_speed = 0.25,
          direction_count = 1,
          scale = 0.5
        }
      }
    },
    flow_length_in_ticks = 360,
    vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
    working_sound =
    {
      sound =
      {
          filename = "__base__/sound/storage-tank.ogg",
          volume = 0.8
      },
      match_volume_to_activity = true,
      apparent_volume = 1.5,
      max_sounds_per_type = 3
    },
    circuit_wire_connection_points = circuit_connector_definitions["bob-small-storage-tank"].points,
    circuit_connector_sprites = circuit_connector_definitions["bob-small-storage-tank"].sprites,
    circuit_wire_max_distance = default_circuit_wire_max_distance
  },

  {
    type = "storage-tank",
    name = "bob-small-storage-tank",
    icon = "__bobplates__/graphics/icons/small-storage-tank.png",
    icon_size = 32,
    flags = {"placeable-player", "player-creation"},
    minable = {mining_time = 0.2, result = "bob-small-storage-tank"},
    max_health = 200,
    corpse = "small-remnants",
    collision_box = {{-0.3, -0.3}, {0.3, 0.3}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    fluid_box =
    {
      base_area = 25,
      pipe_picture = assembler3pipepictures(),
      pipe_covers = pipecoverspictures(),
      pipe_connections =
      {
        { position = { 0, -1} },
        { position = { 0,  1} },
        { position = {-1,  0} },
        { position = { 1,  0} },
      }
    },
    fast_replaceable_group = "pipe",
    window_bounding_box = {util.by_pixel(-3, -5), util.by_pixel(3, 11)},
    pictures =
    {
      picture =
      {
        sheets =
        {
          {
            filename = "__bobplates__/graphics/entity/small-storage-tank-all.png",
            priority = "extra-high",
            frames = 1,
            width = 32,
            height = 62,
            shift = util.by_pixel(0, -15),
          },
          {
            filename = "__bobplates__/graphics/entity/small-storage-tank-shadow.png",
            priority = "extra-high",
            frames = 1,
            width = 52,
            height = 32,
            shift = util.by_pixel(30, 0),
            draw_as_shadow = true,
          }
        }
      },
      fluid_background =
      {
        filename = "__bobplates__/graphics/entity/small-storage-tank-all.png",
        priority = "extra-high",
        width = 1,
        height = 1
      },
      window_background =
      {
        filename = "__bobplates__/graphics/entity/small-storage-tank-all.png",
        priority = "extra-high",
        width = 1,
        height = 1,
      },
      flow_sprite =
      {
        filename = "__bobplates__/graphics/entity/small-storage-tank-all.png",
        priority = "extra-high",
        width = 1,
        height = 1
      },
      gas_flow =
      {
        filename = "__bobplates__/graphics/entity/small-storage-tank-all.png",
        priority = "extra-high",
        line_length = 1,
        width = 1,
        height = 1,
        frame_count = 1,
        axially_symmetrical = false,
        direction_count = 1,
        animation_speed = 0.25,
      }
    },
    flow_length_in_ticks = 360,
    vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
    working_sound =
    {
      sound =
      {
          filename = "__base__/sound/storage-tank.ogg",
          volume = 0.8
      },
      match_volume_to_activity = true,
      apparent_volume = 1.5,
      max_sounds_per_type = 3
    },
    circuit_wire_connection_points = circuit_connector_definitions["bob-small-storage-tank"].points,
    circuit_connector_sprites = circuit_connector_definitions["bob-small-storage-tank"].sprites,
    circuit_wire_max_distance = default_circuit_wire_max_distance
  },

  {
    type = "furnace",
    name = "void-pump",
    icon = "__bobplates__/graphics/icons/void-pump.png",
    icon_size = 32,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 1, result = "void-pump"},
    allowed_effects = {"consumption", "speed", "pollution"},
    max_health = 100,
    fast_replaceable_group = "pipe",
    corpse = "small-remnants",
    resistances =
    {
      {
        type = "fire",
        percent = 80
      },
      {
        type = "explosion",
        percent = 30
      }
    },
    fluid_boxes =
    {
      {
        production_type = "input",
        pipe_covers = pipecoverspictures(),
        base_area = 1,
        base_level = -1,
        pipe_connections = {{type = "input", position = {0, 1}}}
      },
    },
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = 0.15,
    },
    energy_usage = "30kW",
    vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
    repair_sound = { filename = "__base__/sound/manual-repair-simple.ogg" },
    open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
    close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
    collision_box = {{-0.29, -0.29}, {0.29, 0.29}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    crafting_categories = {"void-fluid"},
    crafting_speed = 5,
    result_inventory_size = 0,
    source_inventory_size = 0,
    animation =
    {
      north =
      {
        filename = "__bobplates__/graphics/entity/small-pump/small-pump-up.png",
        width = 46,
        height = 52,
        frame_count = 8,
        shift = {0.09375, 0.03125 + 0.0625},
        animation_speed = 0.5
      },
      east =
      {
        filename = "__bobplates__/graphics/entity/small-pump/small-pump-right.png",
        width = 51,
        height = 56,
        frame_count = 8,
        shift = {0.265625, -0.21875},
        animation_speed = 0.5
      },
      south =
      {
        filename = "__bobplates__/graphics/entity/small-pump/small-pump-down.png",
        width = 61,
        height = 58,
        frame_count = 8,
        shift = {0.421875, -0.125},
        animation_speed = 0.5
      },
      west =
      {
        filename = "__bobplates__/graphics/entity/small-pump/small-pump-left.png",
        width = 56,
        height = 44,
        frame_count = 8,
        shift = {0.3125, 0.0625},
        animation_speed = 0.5
      }
    },
  },
}
)
