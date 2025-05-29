return {
 SMODS.Joker {
    key = 'seat',
    loc_txt = {
      name = 'The Seat',
      text = {
        "Turn all owned {C:attention}consumables{}",
        "{C:dark_edition}Negative{} at end of round",
        "{C:green}#1# in #2#{} chance to {C:red}disappear",
        "{C:inactive,s:0.7,E:1}(Where did this come from?)"
      }
    },
    config = { extra = { odds = 4 } },
    loc_vars = function(self, info_queue, card)
      return { vars = { G.GAME.probabilities.normal, card.ability.extra.odds }}
    end,
  
    rarity = 3,
    atlas = 'GarbJokers',
    pos = { x = 2, y = 9 },
    soul_pos = { x = 3, y = 9 },
    cost = 4,

      unlocked = true, 
      discovered = false, --whether or not it starts discovered
      blueprint_compat = false, --can it be blueprinted/brainstormed/other
      eternal_compat = true, --can it be eternal
      perishable_compat = true, --can it be perishable
      
    set_ability = function(self, card)
      if card.edition ~= "e_negative" then card:set_edition('e_negative', true, true) end
    end,

    calculate = function(self, card, context)
    end
  },

  }