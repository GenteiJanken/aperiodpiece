introvoices = {
				love.audio.newSource("sound/gentlehobo0.ogg"),
				love.audio.newSource("sound/drunk0.ogg"),
				love.audio.newSource("sound/sweep0.ogg"),
				love.audio.newSource("sound/bowie0.ogg"),
				love.audio.newSource("sound/intro.ogg")
				}

voices = {
--[[
	--prototype
	{
		--round1
		love.audio.newSource("sound/prototype.ogg", static)
	},
]]--
	--gentleman
	{
		--round1
		love.audio.newSource("sound/gentlehobo1.ogg"),
		--round2
		love.audio.newSource("sound/gentlehobo2.ogg")
	},

	--scotch
	{
		--round1
		love.audio.newSource("sound/drunk1.ogg"),
		--round2
		love.audio.newSource("sound/drunk2.ogg")


	},

	--sweep
	{
		--round1
		love.audio.newSource("sound/sweep1.ogg"),
		--round2
		love.audio.newSource("sound/sweep2.ogg")
	},

	--bowie
	{
		--round1
		love.audio.newSource("sound/bowie1.ogg"),
		--round2
		love.audio.newSource("sound/bowie2.ogg")


	}

}
