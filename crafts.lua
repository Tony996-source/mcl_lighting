 -- Crafts
 
 minetest.register_craft({
	output = "mcl_lighting:modern_light_rod 4",
	recipe = {
		{"mcl_core:glass", "", "mcl_core:glass"},
		{"mcl_core:glass","mcl_nether:glowstone_dust", "mcl_core:glass"},
		{"mcl_core:glass", "mcl_core:iron_ingot", "mcl_core:glass"},
	}
})

minetest.register_craft({
  output = "mcl_lighting:blue_lantern_f",
  recipe = {
    {"", "mcl_core:iron_nugget", ""},
    {"mcl_core:glass_blue", "mcl_nether:glowstone_dust", "mcl_core:glass_blue"},
    {"mcl_core:iron_nugget", "mcl_core:iron_nugget", "mcl_core:iron_nugget"},
  }
})

minetest.register_craft({
  output = "mcl_lighting:orange_lantern_f",
  recipe = {
    {"", "mcl_core:iron_nugget", ""},
    {"mcl_core:glass_orange", "mcl_nether:glowstone_dust", "mcl_core:glass_orange"},
    {"mcl_core:iron_nugget", "mcl_core:iron_nugget", "mcl_core:iron_nugget"},
  }
})

minetest.register_craft({
	output = 'mcl_lighting:streetpost_d',
	recipe = {
	{'mcl_core:iron_ingot'},
	{'mcl_core:iron_ingot'},
	{'mcl_core:iron_ingot'},
	}
})

minetest.register_craft({
	output = 'mcl_lighting:streetpost_l',
	recipe = {
	{'mcl_core:iron_ingot'},
	{'mcl_core:iron_nugget'},
	{'mcl_core:iron_ingot'},
	}
})

minetest.register_craft({
  output = "mcl_lighting:barlight_c 4",
  recipe = {
    {"mcl_core:iron_ingot", "mcl_nether:glowstone_dust", "mcl_core:iron_ingot"},
    {"mcl_core:gold_ingot", "mcl_core:glass", "mcl_core:gold_ingot"},
  }
})

minetest.register_craft({
  output = "mcl_lighting:barlight_c 2",
  type = "shapeless",
  recipe = {"mcl_lighting:barlight_s"}
})

minetest.register_craft({
  output = "mcl_lighting:barlight_s",
  type = "shapeless",
  recipe = {"mcl_lighting:barlight_c", "mcl_lighting:barlight_c"}
})

minetest.register_craft({
  output = "mcl_lighting:glowlight_modern",
  recipe = {
    {"mcl_core:iron_ingot", "mcl_nether:glowstone_dust", "mcl_core:iron_ingot"},
    {"", "mcl_core:glass", ""},
  }
})

minetest.register_craft({
  output = "mcl_lighting:modern_walllamp",
  recipe = {
    {"mcl_dye:white", "mcl_core:glass", ""},
    {"mcl_core:glass", "mcl_nether:glowstone_dust", "mcl_core:iron_ingot"},
    {"", "mcl_dye:grey", "mcl_core:iron_ingot"},
  }
})

minetest.register_craft({
  output = "mcl_lighting:tablelamp_d",
  recipe = {
    {"mcl_wool:grey", "mcl_nether:glowstone_dust", "mcl_wool:grey"},
    {"", "mcl_core:iron_ingot", ""},
    {"", "mcl_core:iron_ingot", ""},
  }
})

minetest.register_craft({
  output = "mcl_lighting:tablelamp_l",
  recipe = {
    {"mcl_wool:white", "mcl_nether:glowstone_dust", "mcl_wool:white"},
    {"", "mcl_core:iron_ingot", ""},
    {"", "mcl_core:iron_ingot", ""},
  }
})
