return {
    
-- STAMPS

SMODS.Consumable{
  key = 'eternity',
  set = 'Spectral',
  loc_txt = {
    name = 'Eternity',
    text = {
      "Exchange selected Joker",
      "for {E:1,C:legendary}-1 Ante"
    }
  },

  atlas = 'GarbConsumables', pos = { x = 3, y = 0 },
  hidden = true, 
  soul_set = 'Stamp', 
  soul_pos = { x = 4, y = 0 },

    config = {extra = { max_highlighted = 1}},
    
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.max_highlighted }}
    end,

    can_use = function(self, card)
      if #G.jokers.highlighted == 1 and not G.jokers.highlighted[1].ability.eternal then return true else return false end
    end,
  
    use = function(self, card, area, copier)
      play_sound('timpani')
      _card = G.jokers.highlighted[1]
      _card:start_dissolve(nil, false)
      ease_ante(-1)
      delay(0.6)
    end

},

SMODS.Consumable{
  key = 'fruit',
  set = 'Stamp',
  loc_txt = {
    name = 'Fruit',
    text = {
      "Exchange selected Joker",
      "for {C:attention}+#1#{} hand size",
      "next round"
    }
  },

  atlas = 'Stamps', pos = { x = 1, y = 0 },

    config = {extra = { max_highlighted = 1, h_size = 3}},
    
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.h_size }}
    end,

    can_use = function(self, card)
      if #G.jokers.highlighted == 1 and not G.jokers.highlighted[1].ability.eternal then return true else return false end
    end,
  
    use = function(self, card, area, copier)
      play_sound('timpani')
      _card = G.jokers.highlighted[1]
      _card:start_dissolve(nil, false)
      G.hand:change_size(card.ability.extra.h_size)
      G.GAME.round_resets.temp_handsize = (G.GAME.round_resets.temp_handsize or 0) + card.ability.extra.h_size
      delay(0.6)
    end

},

SMODS.Consumable{
  key = 'vintage',
  set = 'Stamp',
  loc_txt = {
    name = 'Vintage',
    text = {
      "Exchange selected Joker",
      "for a different Joker",
      "of the {C:attention}same rarity"
    }
  },

  atlas = 'Stamps', pos = { x = 2, y = 0 },

    config = {extra = { max_highlighted = 1, h_size = 3}},
    
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.h_size }}
    end,

    can_use = function(self, card)
      return #G.jokers.highlighted == 1
			and not G.jokers.highlighted[1].ability.eternal
			and not (
				type(G.jokers.highlighted[1].config.center.rarity) == "number"
				and G.jokers.highlighted[1].config.center.rarity >= 5
			)
    end,
  
    use = function(self, card, area, copier)
      local deleted_joker_key = G.jokers.highlighted[1].config.center.key
      local rarity = G.jokers.highlighted[1].config.center.rarity
      local legendary = nil
      if rarity == 1 then
        rarity = 0
      elseif rarity == 2 then
        rarity = 0.9
      elseif rarity == 3 then
        rarity = 0.99
      elseif rarity == 4 then
        rarity = nil
        legendary = true
      end
      G.jokers.highlighted[1]:start_dissolve(nil, false)
      G.E_MANAGER:add_event(Event({
        trigger = "after",
        delay = 0.4,
        func = function()
          play_sound("timpani")
          local card = create_card("Joker", G.jokers, legendary, rarity, nil, nil, nil, "IstoleThisCodeFromCryptid")
          card:add_to_deck()
          G.jokers:emplace(card)
          card:juice_up(0.3, 0.5)
          if card.config.center.key == deleted_joker_key then
            check_for_unlock({ type = "pr_unlock" })
          end
          return true
        end,
      }))
    end,
  

},

SMODS.Consumable{
  key = 'sealife',
  set = 'Stamp',
  loc_txt = {
    name = 'Sealife',
    text = {
      "Exchange selected Joker",
      "for a {C:attention}Boss Blind reroll{}"
    }
  },

  atlas = 'Stamps', pos = { x = 3, y = 0 },

    config = {extra = { max_highlighted = 1, h_size = 3}},
    
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.h_size }}
    end,

    can_use = function(self, card)
      if #G.jokers.highlighted == 1 and not G.jokers.highlighted[1].ability.eternal then return true else return false end
    end,
  
    use = function(self, card, area, copier)
      play_sound('timpani')
      _card = G.jokers.highlighted[1]
      _card:start_dissolve(nil, false)
      G.from_boss_tag = true
      G.FUNCS.reroll_boss()
      delay(0.6)
    end

},

--[[
SMODS.Consumable{
  key = 'souvenir',
  set = 'Stamp',
  loc_txt = {
    name = 'Souvenir',
    text = {
      "Exchange selected Joker",
      "for up to {C:attention}#1#{} copies",
      "of {C:attention}The Fool{}",
      "{C:inactive}(Must have room)"
    }
  },

  atlas = 'Stamps', pos = { x = 2, y = 0 },

    config = {extra = { max_highlighted = 1, copies = 2, }},
    
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.c_fool
        return { vars = { card.ability.extra.copies }}
    end,

    can_use = function(self, card)
      if #G.jokers.highlighted == 1 and not G.jokers.highlighted[1].ability.eternal and (G.consumeables.config.card_limit - #G.consumeables.cards) > 0 then return true else return false end
    end,
  
    use = function(self, card, area, copier)
      play_sound('timpani')
      _card = G.jokers.highlighted[1]
      _card:start_dissolve(nil, false)
      for i = 1, math.min(card.ability.extra.copies, G.consumeables.config.card_limit - #G.consumeables.cards) do
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            if G.consumeables.config.card_limit > #G.consumeables.cards then
                play_sound('timpani')
                local card = SMODS.create_card{key = "c_fool", no_edition = true}
                G.consumeables:emplace(card)
                card:juice_up(0.3, 0.5)
            end
            return true end }))
      end
      delay(0.6)
    end

},
]]

-- MISC CONSUMABLES

SMODS.Consumable{
    key = 'hunger',
    set = 'Tarot',
    loc_txt = {
      name = 'Hunger',
      text = {
        "Enhances {C:attention}#1#",
        "selected cards to",
        "{C:attention}#2#s"
      }
    },
  
    atlas = 'GarbConsumables', pos = { x = 2, y = 0 },
  
      config = {extra = { max_highlighted = 2, enhancement = "Infected Card" }},
      
      loc_vars = function(self, info_queue, card)
          info_queue[#info_queue+1] = G.P_CENTERS.m_garb_infected
          return { vars = { card.ability.extra.max_highlighted, card.ability.extra.enhancement }}
      end,
  
    can_use = function(self, card)
      if #G.hand.highlighted > 0 and #G.hand.highlighted < card.ability.extra.max_highlighted + 1 then return true else return false end
    end,
  
    
  
      use = function(self, card)
          G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
              play_sound('tarot1')
              card:juice_up(0.3, 0.5)
              return true end }))
          conversionTarot(G.hand.highlighted, 'm_garb_infected')    
          delay(0.6)
          return true
    end
  },
  
  
  SMODS.Consumable{
    key = 'aeon',
    set = 'Spectral',
    loc_txt = {
      name = 'The Aeon',
      text = {
        "Creates a {E:1,C:dark_edition}Negative{} copy",
      "of selected {C:attention}Joker{}",
      "{C:red}-1{} hand size"
      }
    },
    atlas = 'GarbConsumables', pos = { x = 0, y = 0 },
    hidden = true, 
    soul_set = 'Tarot', 
    soul_pos = { x = 1, y = 0 },
  
    can_use = function(self, card)
      if #G.jokers.highlighted == 1 then return true else return false end
    end,
  
    use = function(self, card, area, copier)
      G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
        play_sound('timpani')
        G.hand:change_size(-1)
        local new_card = SMODS.create_card{key = G.jokers.highlighted[1].config.center_key, edition = "e_negative"}
        new_card:add_to_deck()
        G.jokers:emplace(new_card)
        card:juice_up(0.3, 0.5)
        return true end }))
      delay(0.6)
      return true
    end
  }
  
}