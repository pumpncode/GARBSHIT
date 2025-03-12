return {

-- META STUFF

SMODS.Atlas({
	key = "modicon",
	path = "garb_icon.png",
	px = 32,
	py = 32,
}),

SMODS.Atlas({
	key = "balatro",
	path = "Logo.png",
	px = 333,
	py = 216,
  prefix_config = { key = false }
}),

SMODS.Atlas{
    key = 'GarbJokers', --atlas key
    path = 'Jokers.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
},

SMODS.Atlas{
  key = 'GarbConsumables', --atlas key
  path = 'Consumables.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
  px = 65, --width of one card
  py = 95 -- height of one card
},

SMODS.Atlas{
    key = 'GarbDecks', --atlas key
    path = 'Decks.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
  },

SMODS.Atlas{
  key = 'GarbEnhancements', --atlas key
  path = 'Enhancements.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
  px = 71, --width of one card
  py = 95 -- height of one card
},

	SMODS.Sound {
    key = "mirrorz",
    path = {
        ["default"] = "mirror2.ogg"
    }
	},
	
	SMODS.Sound {
    key = "abadeus1",
    path = {
        ["default"] = "abadeus2.ogg"
    },
	volume = 0.5
	},
	
	SMODS.Sound {
    key = "explosion",
    path = {
        ["default"] = "explosion.ogg"
    },
	volume = 0.5
	},
	
	SMODS.Sound {
    key = "surge",
    path = {
        ["default"] = "surge2.ogg"
    },
	volume = 0.4
	},
	
	SMODS.Sound {
    key = "surge",
    path = {
        ["default"] = "surge2.ogg"
    },
	volume = 0.2
	},
	
	SMODS.Sound {
    key = "squeak",
    path = {
        ["default"] = "squeak.wav"
    },
	volume = 0.4
	},

  SMODS.Sound {
    key = "scopacane",
    path = {
        ["default"] = "scopacane2.ogg"
    },
	volume = 0.5
	},

  
  SMODS.Sound {
    key = "jimboss_defeat",
    path = {
        ["default"] = "jimboss_defeat.ogg"
    },
	volume = 0.5
	},

  SMODS.Sound {
    key = "jimboss_hit",
    path = {
        ["default"] = "jimboss_hit.wav"
    },
	volume = 0.5
	},

  SMODS.Sound {
    key = "infect",
    path = {
        ["default"] = "infect.ogg"
    },
	volume = 0.5
	},

  SMODS.Sound {
    key = "music_fukkireta",
    path = {
        ["default"] = "music_fukkireta.ogg"
    },
    sync = false,
    pitch = 1,
    select_music_track = function()
      return next(SMODS.find_card("j_garb_teto")) and 20 and config.fukkireta or false
    end
}

}