 -- Crafts

minetest.register_craft({
  output = "lighting:blue_lantern_f",
  recipe = {
    {"", "mcl_core:iron_ingot", ""},
    {"mcl_core:glass_blue", "mcl_core:torch", "mcl_core:glass_blue"},
    {"mcl_core:stick", "mcl_core:iron_ingot", "mcl_core:stick"}
  }
})

minetest.register_craft({
  output = "lighting:lantern_f",
  recipe = {
    {"", "mcl_core:iron_ingot", ""},
    {"mcl_core:glass_orange", "mcl_core:torch", "mcl_core:glass_orange"},
    {"mcl_core:stick", "mcl_core:iron_ingot", "mcl_core:stick"}
  }
})

minetest.register_craft({
	output = "lighting:light_rod 4",
	recipe = {
		{"mcl_mobitems:blaze_rod"},
		{"mcl_mobitems:blaze_rod"},
		{"mcl_core:iron_ingot"},
	},
})
