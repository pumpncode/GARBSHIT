return {
SMODS.Atlas({
	key = "garb_achievements",
	path = "garb_achievements.png",
	px = 66,
	py = 66
}),

SMODS.Achievement({
	key = "regicide",
	bypass_all_unlocked = true,
	atlas = "garb_achievements",
	-- reset_on_startup = true,
	hidden_name = true,
	unlock_condition = function(self, args)
		if args.type == "regicide" then
			return true
		end
	end
}),
}