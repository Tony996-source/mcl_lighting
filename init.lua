local modpath = minetest.get_modpath("mcl_lighting").. DIR_DELIM

mcl_lighting = {}

dofile(modpath.."crafts.lua")

mcl_lighting = {}

function mcl_lighting.register_variants(variants, fixedDef)
  for _,variant in ipairs(variants) do
    local name = variant.name
    local def = table.copy(fixedDef)

    for k,v in pairs(variant) do
      if k ~= "name" then
        def[k] = v
      end
    end

    minetest.register_node(name, def)
  end
end

function mcl_lighting.on_place_hanging(itemstack, placer, pointed_thing, replaceName)
  local ceiling = minetest.get_node(vector.add(pointed_thing.above,
    {x=0, y=1, z=0}))

  if ceiling and ceiling.name ~= "air"
    and minetest.get_item_group(ceiling.name, "mounted_ceiling") == 0
    and not (placer and placer:get_player_control().sneak) then

    local name = itemstack:get_name()
    local fakestack = itemstack
    fakestack:set_name(replaceName)

    minetest.item_place(fakestack, placer, pointed_thing, 0)
    itemstack:set_name(name)

    return itemstack
  end

  minetest.item_place(itemstack, placer, pointed_thing, 0)
  return itemstack
end

function mcl_lighting.rotate_and_place(itemstack, placer, pointed_thing, lookup)
  local dir = minetest.dir_to_wallmounted(vector.subtract(pointed_thing.under, pointed_thing.above))
  local fDirs = lookup or {[0] = 20, 0, 16, 12, 8, 4}
  minetest.item_place(itemstack, placer, pointed_thing, fDirs[dir] or 0)
  return itemstack
end

local path = minetest.get_modpath("mcl_lighting")

-- Light Rod

minetest.register_node("mcl_lighting:modern_light_rod", {
	description = ("Light Rod"),
	_doc_items_hidden = false,
	stack_max = 64,
	tiles = {
		"light_rod_top.png",
		"light_rod_bottom.png",
		"light_rod_side.png",
		"light_rod_side.png",
		"light_rod_side.png",
		"light_rod_side.png",
	},
	drawtype = "nodebox",
	is_ground_content = false,
	paramtype = "light",
	paramtype2 = "facedir",
	light_source = minetest.LIGHT_MAX,
	sunlight_propagates = true,
	groups = {handy=1, pickaxey=1, axey=1},
	sounds = mcl_sounds.node_sound_wood_defaults(),
	_mcl_blast_resistance = 2,
	_mcl_hardness = 2,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.125, -0.5, -0.125, 0.125, -0.4375, 0.125}, -- Base
			{-0.0625, -0.4375, -0.0625, 0.0625, 0.5, 0.0625}, -- Rod
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.125, -0.5, -0.125, 0.125, 0.5, 0.125}, -- Base
		},
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.125, -0.5, -0.125, 0.125, 0.5, 0.125}, -- Base
		},
	},
	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" then
			return itemstack
		end

		local p0 = pointed_thing.under
		local p1 = pointed_thing.above
		local param2 = 0

		local placer_pos = placer:get_pos()
		if placer_pos then
			local dir = {
				x = p1.x - placer_pos.x,
				y = p1.y - placer_pos.y,
				z = p1.z - placer_pos.z
			}
			param2 = minetest.dir_to_facedir(dir)
		end

		if p0.y - 1 == p1.y then
			param2 = 20
		elseif p0.x - 1 == p1.x then
			param2 = 16
		elseif p0.x + 1 == p1.x then
			param2 = 12
		elseif p0.z - 1 == p1.z then
			param2 = 8
		elseif p0.z + 1 == p1.z then
			param2 = 4
		end

		return minetest.item_place(itemstack, placer, pointed_thing, param2)
	end,
})

-- blue lantern

minetest.register_node("mcl_lighting:blue_lantern_f", {
  description = "lue Lantern (floor, wall, or ceiling)",
  _doc_items_hidden = false,
	stack_max = 64,
  drawtype = "mesh",
  mesh = "blue_lantern_f.obj",
  tiles = {"blue_lantern.png", "metal_dark_32.png"},
  	groups = {handy=1, pickaxey=1, axey=1},
	sounds = mcl_sounds.node_sound_wood_defaults(),
	_mcl_blast_resistance = 2,
	_mcl_hardness = 2,
  collision_box = {
    type = "fixed",
    fixed = {-3/16, -1/2, -3/16, 3/16, 1/16, 3/16}
  },
  selection_box = {
    type = "fixed",
    fixed = {-3/16, -1/2, -3/16, 3/16, 1/16, 3/16}
  },
  paramtype = "light",
  light_source = minetest.LIGHT_MAX,
  on_place = function(itemstack, placer, pointed_thing)
		local wdir = minetest.dir_to_wallmounted(
      vector.subtract(pointed_thing.under, pointed_thing.above))
		local fakestack = itemstack

		if wdir == 0 then
			fakestack:set_name("mcl_lighting:blue_lantern_c")
		elseif wdir == 1 then
			fakestack:set_name("mcl_lighting:blue_lantern_f")
		else
			fakestack:set_name("mcl_lighting:blue_lantern_w")
		end

		itemstack = minetest.item_place(fakestack, placer, pointed_thing, wdir)
		itemstack:set_name("mcl_lighting:blue_lantern_f")

		return itemstack
	end,
})

minetest.register_node("mcl_lighting:blue_lantern_c", {
  drawtype = "mesh",
  mesh = "blue_lantern_c.obj",
  tiles = {"blue_lantern.png", "metal_dark_32.png"},
  collision_box = {
    type = "fixed",
    fixed = {-3/16, -1/16, -3/16, 3/16, 1/2, 3/16}
  },
  selection_box = {
    type = "fixed",
    fixed = {-3/16, 0, -3/16, 3/16, 1/2, 3/16}
  },
  paramtype = "light",
  light_source = minetest.LIGHT_MAX,
  	groups = {handy=1, pickaxey=1, axey=1, not_in_creative_inventory = 1},
	sounds = mcl_sounds.node_sound_wood_defaults(),
	_mcl_blast_resistance = 2,
	_mcl_hardness = 2,
  drop = "mcl_lighting:blue_lantern_f",
})

minetest.register_node("mcl_lighting:blue_lantern_w", {
  drawtype = "mesh",
  mesh = "blue_lantern_w.obj",
  tiles = {"blue_lantern.png", "metal_dark_32.png"},
  collision_box = {
    type = "fixed",
    fixed = {-3/16, -1/4, -5/16, 3/16, 1/8, 3/16}
  },
  selection_box = {
    type = "wallmounted",
    wall_bottom = {-3/16, -1/4, -5/16, 3/16, 1/8, 3/16},
    wall_side = {-1/4, -5/16, -3/16, 1/8, 3/16, 3/16},
    wall_top = {-3/16, -1/8, -5/16, 3/16, 1/4, 3/16}
  },
  paramtype = "light",
  paramtype2 = "wallmounted",
  light_source = minetest.LIGHT_MAX,
  groups = {handy=1, pickaxey=1, axey=1, not_in_creative_inventory = 1},
  sounds = mcl_sounds.node_sound_glass_defaults(),
  _mcl_blast_resistance = 2,
	_mcl_hardness = 2,
  drop = "mcl_lighting:blue_lantern_f",
})

-- Orange lantern

minetest.register_node("mcl_lighting:orange_lantern_f", {
  description = "Orange Lantern (floor, wall, or ceiling)",
  _doc_items_hidden = false,
	stack_max = 64,
  drawtype = "mesh",
  mesh = "orange_lantern_f.obj",
  tiles = {"orange_lantern.png", "metal_dark_32.png"},
  	groups = {handy=1, pickaxey=1, axey=1},
	sounds = mcl_sounds.node_sound_wood_defaults(),
	_mcl_blast_resistance = 2,
	_mcl_hardness = 2,
  collision_box = {
    type = "fixed",
    fixed = {-3/16, -1/2, -3/16, 3/16, 1/16, 3/16}
  },
  selection_box = {
    type = "fixed",
    fixed = {-3/16, -1/2, -3/16, 3/16, 1/16, 3/16}
  },
  paramtype = "light",
  light_source = minetest.LIGHT_MAX,
  on_place = function(itemstack, placer, pointed_thing)
		local wdir = minetest.dir_to_wallmounted(
      vector.subtract(pointed_thing.under, pointed_thing.above))
		local fakestack = itemstack

		if wdir == 0 then
			fakestack:set_name("mcl_lighting:orange_lantern_c")
		elseif wdir == 1 then
			fakestack:set_name("mcl_lighting:orange_lantern_f")
		else
			fakestack:set_name("mcl_lighting:orange_lantern_w")
		end

		itemstack = minetest.item_place(fakestack, placer, pointed_thing, wdir)
		itemstack:set_name("mcl_lighting:orange_lantern_f")

		return itemstack
	end,
})

minetest.register_node("mcl_lighting:orange_lantern_c", {
  drawtype = "mesh",
  mesh = "orange_lantern_c.obj",
  tiles = {"orange_lantern.png", "metal_dark_32.png"},
  collision_box = {
    type = "fixed",
    fixed = {-3/16, -1/16, -3/16, 3/16, 1/2, 3/16}
  },
  selection_box = {
    type = "fixed",
    fixed = {-3/16, 0, -3/16, 3/16, 1/2, 3/16}
  },
  paramtype = "light",
  light_source = minetest.LIGHT_MAX,
  	groups = {handy=1, pickaxey=1, axey=1, not_in_creative_inventory = 1},
	sounds = mcl_sounds.node_sound_wood_defaults(),
	_mcl_blast_resistance = 2,
	_mcl_hardness = 2,
  drop = "mcl_lighting:orange_lantern_f",
})

minetest.register_node("mcl_lighting:orange_lantern_w", {
  drawtype = "mesh",
  mesh = "orange_lantern_w.obj",
  tiles = {"orange_lantern.png", "metal_dark_32.png"},
  collision_box = {
    type = "fixed",
    fixed = {-3/16, -1/4, -5/16, 3/16, 1/8, 3/16}
  },
  selection_box = {
    type = "wallmounted",
    wall_bottom = {-3/16, -1/4, -5/16, 3/16, 1/8, 3/16},
    wall_side = {-1/4, -5/16, -3/16, 1/8, 3/16, 3/16},
    wall_top = {-3/16, -1/8, -5/16, 3/16, 1/4, 3/16}
  },
  paramtype = "light",
  paramtype2 = "wallmounted",
  light_source = minetest.LIGHT_MAX,
  groups = {handy=1, pickaxey=1, axey=1, not_in_creative_inventory = 1},
  sounds = mcl_sounds.node_sound_glass_defaults(),
  _mcl_blast_resistance = 2,
	_mcl_hardness = 2,
  drop = "mcl_lighting:orange_lantern_f",
})

-- Modern cieling light
minetest.register_node("mcl_lighting:glowlight_modern", {
  description = "Modern Ceiling Light",
  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = {-1/4, 3/8, -1/4, 1/4, 1/2, 1/4}
  },
  tiles = {"metal_dark.png",
    "metal_dark.png^modern_block.png"},
  paramtype = "light",
  paramtype2 = "facedir",
  light_source = minetest.LIGHT_MAX,
  groups = {handy=1, pickaxey=1, axey=1},
  sounds = mcl_sounds.node_sound_wood_defaults(),
  _mcl_blast_resistance = 2,
	_mcl_hardness = 2,
  on_place = function(itemstack, placer, pointed_thing)
    return mcl_lighting.rotate_and_place(itemstack, placer, pointed_thing,
      {[0] = 0, 20, 12, 16, 4, 8})
  end,
})

-- Table lamps
mcl_lighting.register_variants({
  {name = "mcl_lighting:tablelamp_d",
    description = "Modern Table Lamp (dark)",
    tiles = {"metal_light_32.png^modern_tablelamp_o.png",
    "modern_tablelamp_d.png"}},
  {name = "mcl_lighting:tablelamp_l",
    description = "Modern Table Lamp (light)",
    tiles = {"metal_dark_32.png^modern_tablelamp_o.png",
    "modern_tablelamp_l.png"}},
},
{
  drawtype = "mesh",
  mesh = "modern_tablelamp.obj",
  collision_box = {
    type = "fixed",
    fixed = {-1/4, -1/2, -1/4, 1/4, 7/16, 1/4}
  },
  selection_box = {
    type = "fixed",
    fixed = {-1/4, -1/2, -1/4, 1/4, 7/16, 1/4}
  },
  paramtype = "light",
  light_source = minetest.LIGHT_MAX,
  groups = {handy=1, pickaxey=1, axey=1},
  sounds = mcl_sounds.node_sound_wood_defaults(),
  _mcl_blast_resistance = 2,
	_mcl_hardness = 2,
})

-- modern wall lamp

minetest.register_node("mcl_lighting:modern_walllamp", {
  description = "Modern Wall Lamp",
  drawtype = "mesh",
  mesh = "modern_walllamp.obj",
  collision_box = {
    type = "fixed",
    fixed = {-1/8, -3/8, 1/8, 1/8, 1/4, 1/2}
  },
  selection_box = {
    type = "fixed",
    fixed = {-1/8, -3/8, 1/8, 1/8, 1/4, 1/2}
  },
  tiles = {"metal_dark_32.png^modern_walllamp.png"},
  paramtype = "light",
  paramtype2 = "facedir",
  light_source = minetest.LIGHT_MAX,
  groups = {handy=1, pickaxey=1, axey=1},
  sounds = mcl_sounds.node_sound_wood_defaults(),
  _mcl_blast_resistance = 2,
	_mcl_hardness = 2,
  on_place = function(itemstack, placer, pointed_thing)
    return mcl_lighting.rotate_and_place(itemstack, placer, pointed_thing,
      {[0] = 6, 4, 1, 3, 0, 2})
  end,
})

-- Light bars
minetest.register_node("mcl_lighting:barlight_c", {
  description = "Ceiling Bar Light (connecting)",
  drawtype = "nodebox",
  node_box = {
    type = "connected",
    fixed = {-1/8,  3/8, -1/8, 1/8,  1/2, 1/8},
    connect_front = {-1/8, 3/8, -1/2, 1/8,  1/2, -1/8},
    connect_left = {-1/2, 3/8, -1/8, -1/8, 1/2, 1/8},
    connect_back = {-1/8, 3/8, 1/8, 1/8, 1/2, 1/2},
    connect_right = {1/8, 3/8, -1/8, 1/2, 1/2, 1/8},
  },
  connects_to = {"mcl_lighting:barlight_c", "mcl_lighting:barlight_s",
    "modern:streetpost_d", ":streetpost_l"},
  tiles = {"metal_dark.png", "modern_barlight.png",
    "metal_dark.png"},
  paramtype = "light",
  light_source = minetest.LIGHT_MAX,
  groups = {handy=1, pickaxey=1, axey=1},
  sounds = mcl_sounds.node_sound_wood_defaults(),
  _mcl_blast_resistance = 2,
	_mcl_hardness = 2,
})

minetest.register_node("mcl_lighting:barlight_s", {
  description = "Ceiling Bar Light (straight)",
  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = {-1/2, 3/8, -1/8, 1/2, 1/2, 1/8},
  },
  tiles = {"metal_dark.png", "modern_barlight.png",
    "metal_dark.png"},
  paramtype = "light",
  paramtype2 = "facedir",
  light_source = minetest.LIGHT_MAX,
  groups = {handy=1, pickaxey=1, axey=1},
  sounds = mcl_sounds.node_sound_wood_defaults(),
  _mcl_blast_resistance = 2,
	_mcl_hardness = 2,
})

-- street post

mcl_lighting.register_variants({
  {name = "mcl_lighting:streetpost_d",
    description = "Street Lamp Post (dark)--connects to bar lights",
    tiles = {"metal_dark.png"}},
  {name = "mcl_lighting:streetpost_l",
    description = "Street Lamp Post (light)--connects to bar lights",
    tiles = {"metal_light.png"}}
},
{
  drawtype = "nodebox",
  node_box = {
    type = "connected",
    fixed = {-1/16, -1/2, -1/16, 1/16,  1/2, 1/16},
    connect_front = {-1/16,  3/8, -1/2, 1/16,  7/16, -1/16},
    connect_left = {-1/2, 3/8, -1/16, -1/16, 7/16, 1/16},
    connect_back = {-1/16, 3/8, 1/16, 1/16, 7/16, 1/2},
    connect_right = {1/16, 3/8, -1/16, 1/2, 7/16, 1/16},
  },
  connects_to = {"mcl_lighting:barlight_c", "mcl_lighting:barlight_s"},
  paramtype = "light",
  groups = {handy=1, pickaxey=1, axey=1},
  sounds = mcl_sounds.node_sound_wood_defaults(),
  _mcl_blast_resistance = 2,
	_mcl_hardness = 2,
})
