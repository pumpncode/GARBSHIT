return {
    
-- CONSUMABLES

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
      "of selected {C:attention}Joker{}"
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