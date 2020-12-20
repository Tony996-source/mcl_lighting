 -- Crafts

minetest.register_craft({
  output = "mcl_lighting:blue_lantern_f",
  recipe = {
    {"", "mcl_core:iron_nugget", ""},
    {"mcl_core:glass_blue", "mcl_torches:torch", "mcl_core:glass_blue"},
    {"mcl_core:iron_nugget", "mcl_core:iron_nugget", "mcl_core:iron_nugget"}
  }
})

minetest.register_craft({
  output = "mcl_lighting:lantern_f",
  recipe = {
    {"", "mcl_core:iron_nugget", ""},
    {"mcl_core:glass_orange", "mcl_torches:torch", "mcl_core:glass_orange"},
    {"mcl_core:iron_nugget", "mcl_core:iron_nugget", "mcl_core:iron_nugget"}
  }
})

minetest.register_craft({
	output = "mcl_lighting:light_rod 4",
	recipe = {
		{"mcl_mobitems:blaze_rod"},
		{"mcl_mobitems:blaze_rod"},
		{"mcl_core:iron_ingot"},
	},
})
