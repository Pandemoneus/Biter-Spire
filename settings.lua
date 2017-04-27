data:extend({
	{
		type = "int-setting",
		name = "biter-spire-minimum-base-size",
		setting_type = "runtime-global",
		default_value = 10,
		maximum_value = 1000,
		minimum_value = 1,
	},
  {
		type = "int-setting",
		name = "biter-spire-base-generation",
		setting_type = "runtime-global",
		default_value = 10000000,
		maximum_value = 1000000000000000,
		minimum_value = 1,
	},
    {
		type = "double-setting",
		name = "biter-spire-distance-scale-factor",
		setting_type = "runtime-global",
		default_value = 0.001,
		maximum_value = 100,
		minimum_value = 0,
	},
  {
		type = "bool-setting",
		name = "biter-spire-scale-with-distance",
		setting_type = "runtime-global",
		default_value = true,
	},
})
