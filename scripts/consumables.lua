return {
    
  SMODS.ConsumableType{
    key = 'Stamp',
    primary_colour = HEX("73A557"),
    secondary_colour = HEX("73A557"),
    loc_txt = {
        name = 'Stamp', -- used on card type badges
        collection = 'Stamp Cards', -- label for the button to access the collection
        undiscovered = { -- description for undiscovered cards in the collection
            name = 'Not Discovered',
            text = {
                "Purchase or use",
                "this card in an",
                "unseeded run to",
                "learn what it does"
            }       
        },
    },
    shop_rate = 0.0,
    default = "c_garb_fruit"
},

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
      check_for_unlock({ type = "cycle_deck" })
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
      "of the {C:attention}same rarity",
      "{C:inactive,s:0.9}(New Joker will not be {C:dark_edition,s:0.9}Negative{C:inactive,s:0.9})"
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
			) and not (
        G.jokers.highlighted[1].edition
        and G.jokers.highlighted[1].edition.key == 'e_negative'
        and (G.jokers.config.card_limit - #G.jokers.cards) <= 0
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
        check_for_unlock({ type = "albert_deck" })
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

SMODS.Consumable{
  key = 'souvenir',
  set = 'Stamp',
  loc_txt = {
    name = 'Souvenir',
    text = {
      "Exchange selected",
      "{C:uncommon}Uncommon{} Joker",
      "for a {C:attention}Voucher Tag{}"
    }
  },

  atlas = 'Stamps', pos = { x = 4, y = 0 },

    config = {extra = { }},
    
    loc_vars = function(self, info_queue, card)
      info_queue[#info_queue+1] = {set = "Tag", key = "tag_voucher", specific_vars = {}}
        return { vars = {  }}
    end,

    can_use = function(self, card)
      if (#G.jokers.highlighted == 1) and (G.jokers.highlighted[1].config.center.rarity == 2 or G.jokers.highlighted[1].config.center.rarity == 0.9) and not (G.jokers.highlighted[1].ability.eternal) then return true else return false end
    end,
  
    use = function(self, card, area, copier)
      play_sound('timpani')
      _card = G.jokers.highlighted[1]
      _card:start_dissolve(nil, false)
      add_tag(Tag('tag_voucher'))
      delay(0.6)
    end

},

SMODS.Consumable{
  key = 'mushroom',
  set = 'Stamp',
  loc_txt = {
    name = 'Mushroom',
    text = {
      "Exchange selected Joker",
      "to add {C:dark_edition}Foil{}, {C:dark_edition}Holographic{}, or",
      "{C:dark_edition}Polychrome{} edition",
      "to a random {C:attention}Joker"
    }
  },

  atlas = 'Stamps', pos = { x = 0, y = 1 },

    config = {extra = { }},
    
    loc_vars = function(self, info_queue, card)
      info_queue[#info_queue+1] = G.P_CENTERS.e_foil
      info_queue[#info_queue+1] = G.P_CENTERS.e_holo
      info_queue[#info_queue+1] = G.P_CENTERS.e_polychrome
        return { vars = {  }}
    end,

    can_use = function(self, card)
      local exchange = (#G.jokers.highlighted == 1) and not (G.jokers.highlighted[1].ability.eternal)
      eligible_strength_jokers = EMPTY(eligible_strength_jokers)
      for k, v in pairs(G.jokers.cards) do
        if v.ability.set == 'Joker' and (not v.edition) and v ~= G.jokers.highlighted[1] then
            table.insert(eligible_strength_jokers, v)
        end
      end
      return (#eligible_strength_jokers > 0 or false) and exchange
    end,
  
    use = function(self, card, area, copier)
      play_sound('timpani')
      _card = G.jokers.highlighted[1]
      _card:start_dissolve(nil, false)
      local eligible_card = pseudorandom_element(eligible_strength_jokers, pseudoseed("shroomie"))
      local edition = poll_edition('shroomie', nil, true, true,  {"e_foil", "e_holo","e_polychrome"})
      eligible_card:set_edition(edition, true)
      check_for_unlock({type = 'have_edition'})
      delay(0.6)
      return true
    end

},

SMODS.Consumable{
  key = 'creature',
  set = 'Stamp',
  loc_txt = {
    name = 'Creature',
    text = {
      "Exchange selected Joker",
      "for up to {C:attention}#1#{} random",
      "{C:spectral}Spectral{} cards",
      "{C:inactive}(Must have room)"
    }
  },

  atlas = 'Stamps', pos = { x = 1, y = 1 },

    config = {extra = { max_highlighted = 1, copies = 2, }},
    
    loc_vars = function(self, info_queue, card)
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
                local card = SMODS.create_card{set = "Spectral", no_edition = true}
                G.consumeables:emplace(card)
                card:juice_up(0.3, 0.5)
            end
            return true end }))
      end
      delay(0.6)
    end

},

SMODS.Consumable{
  key = 'spaceship',
  set = 'Stamp',
  loc_txt = {
    name = 'Spaceship',
    text = {
      "Exchange selected Joker",
      "to upgrade {C:attention}most played",
      "{C:attention}poker hand{} by {C:attention}#1#{} levels"
    }
  },

  atlas = 'Stamps', pos = { x = 2, y = 1 },

    config = {extra = { orbital_hand = 1, levels = 3}},
    
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.levels }}
    end,

    can_use = function(self, card)
      if #G.jokers.highlighted == 1 and not G.jokers.highlighted[1].ability.eternal then return true else return false end
    end,
  
    use = function(self, card, area, copier)
      play_sound('timpani')
      _card = G.jokers.highlighted[1]
      _card:start_dissolve(nil, false)
      local _planet, _hand, _tally = nil, nil, 0
      for k, v in ipairs(G.handlist) do
        if G.GAME.hands[v].visible and G.GAME.hands[v].played > _tally then
          _hand = v
          _tally = G.GAME.hands[v].played
        end
      end
      _hand = _hand or "High Card"
      update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {
        handname= _hand,
        chips = G.GAME.hands[_hand].chips,
        mult = G.GAME.hands[_hand].mult,
        level= G.GAME.hands[_hand].level})
      level_up_hand(card, _hand, nil, card.ability.extra.levels)
      update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})      
      delay(0.6)
    end

},

SMODS.Consumable{
  key = 'breakfast',
  set = 'Stamp',
  loc_txt = {
    name = 'Breakfast',
    text = {
      "Exchange selected Joker",
      "for {C:chips}+#1#{} hands",
      "for one round"
    }
  },
    atlas = 'Stamps', pos = { x = 3, y = 1 },

    config = {extra = { hand = 2 }},
    
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.hand }}
    end,

    can_use = function(self, card)
      if #G.jokers.highlighted == 1 and not G.jokers.highlighted[1].ability.eternal then return true else return false end
    end,
  
    use = function(self, card, area, copier)
      play_sound('timpani')
      _card = G.jokers.highlighted[1]
      _card:start_dissolve(nil, false)
      G.GAME.round_resets.temp_hands = (G.GAME.round_resets.temp_hands or 0) + card.ability.extra.hand
      G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hand
      ease_hands_played(card.ability.extra.hand)
      delay(0.6)
    end
},

SMODS.Consumable{
  key = 'mascot',
  set = 'Stamp',
  loc_txt = {
    name = 'Mascot',
    text = {
      "Exchange selected Joker",
      "for up to {C:attention}#1#{} random",
      "{C:stamp}Stamp{} cards",
      "{C:inactive}(Must have room)"
    }
  },

  atlas = 'Stamps', pos = { x = 4, y = 1 },

    config = {extra = { max_highlighted = 1, copies = 2, }},
    
    loc_vars = function(self, info_queue, card)
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
                local card = SMODS.create_card{set = "Stamp", no_edition = true}
                G.consumeables:emplace(card)
                card:juice_up(0.3, 0.5)
            end
            return true end }))
      end
      delay(0.6)
    end

},

SMODS.Consumable{
  key = 'matcha',
  set = 'Stamp',
  loc_txt = {
    name = 'Matcha',
    text = {
      "Exchange selected Joker",
      "for {C:mult}+#1#{} discards",
      "for one round"
    }
  },
    atlas = 'Stamps', pos = { x = 0, y = 2 },

    config = {extra = { discards = 3 }},
    
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.discards }}
    end,

    can_use = function(self, card)
      if #G.jokers.highlighted == 1 and not G.jokers.highlighted[1].ability.eternal then return true else return false end
    end,
  
    use = function(self, card, area, copier)
      play_sound('timpani')
      _card = G.jokers.highlighted[1]
      _card:start_dissolve(nil, false)
      G.GAME.round_resets.temp_discards = (G.GAME.round_resets.temp_discards or 0) + card.ability.extra.discards
      G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.discards
      ease_discard(card.ability.extra.discards)
      delay(0.6)
    end
},

SMODS.Consumable{
  key = 'jimbo',
  set = 'Stamp',
  loc_txt = {
    name = 'Jimbo',
    text = {
      "Exchange selected",
      "{V:1}#1#{} Joker for {C:money}$#2#{}",
      "{C:inactive,E:1}(Hey! That's me!)"
    }
  },
    atlas = 'Stamps', pos = { x = 1, y = 2 },

    config = {extra = { rarity = 1, rarity_text = "Common", money = 5 }},
    
    set_ability = function(self, card, initial, delay_sprites)
      local rarities = {}
      if G.jokers then
        for k, v in pairs(G.jokers.cards) do
          if v.ability.set == 'Joker'	and type(v.config.center.rarity) == "number" and not (type(v.config.center.rarity) == "number" and v.config.center.rarity >= 5) then
             table.insert(rarities, v.config.center.rarity)
          end
        end  
      end
      card.ability.extra.rarity = pseudorandom_element(rarities, pseudoseed('JohnBalatro')) or 1
      card.ability.extra.rarity_text =  ((card.ability.extra.rarity == 1) and "Common") or ((card.ability.extra.rarity == 2) and "Uncommon") or ((card.ability.extra.rarity == 3) and "Rare") or ((card.ability.extra.rarity == 4) and "Legendary")
      card.ability.extra.money = 5 * card.ability.extra.rarity
    end,

    loc_vars = function(self, info_queue, card)
      local rarity_color = G.C.RARITY[card.ability.extra.rarity]
      return { vars = { card.ability.extra.rarity_text, card.ability.extra.money, colours = {rarity_color}}}
    end,

    can_use = function(self, card)
      if #G.jokers.highlighted == 1 and G.jokers.highlighted[1].config.center.rarity == card.ability.extra.rarity and not G.jokers.highlighted[1].ability.eternal then return true else return false end
    end,
  
    use = function(self, card, area, copier)
      play_sound('timpani')
      _card = G.jokers.highlighted[1]
      _card:start_dissolve(nil, false)
      ease_dollars(card.ability.extra.money)
      delay(0.6)
    end
},

SMODS.Consumable{
  key = 'lizard',
  set = 'Stamp',
  loc_txt = {
    name = 'Lizard',
    text = {
      "Exchange selected Joker",
      "for up to {C:attention}#1#{} copies",
      "of {C:tarot}The Fool{}",
      "{C:inactive}(Must have room)"
    }
  },

  atlas = 'Stamps', pos = { x = 2, y = 2 },

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

-- PLANETS
  SMODS.Consumable{
    key = "lowas",
	  set = "Planet",
    loc_txt = {
      name = 'LOWAS',
      text = {
					"{S:0.8}({S:0.8,V:1}lvl.#2#{S:0.8}){} Level up",
					"{C:attention}#1#",
					"{C:mult}+#3#{} Mult and",
					"{C:chips}+#4#{} chips",
}
    },
    
	config = { hand_type = "garb_str_house", softlock = true },
	pos = { x = 3, y = 1 },
	atlas = "GarbConsumables",
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				localize("garb_str_house", "poker_hands"),
				G.GAME.hands["garb_str_house"].level,
				G.GAME.hands["garb_str_house"].l_mult,
				G.GAME.hands["garb_str_house"].l_chips,
				colours = {
					(
						(to_big(G.GAME.hands["garb_str_house"].level) == to_big(1)) and G.C.UI.TEXT_DARK
					),
				},
			},
		}
	end,
  },

  SMODS.Consumable{
    key = "lohac",
	  set = "Planet",
    loc_txt = {
      name = 'LOHAC',
      text = {
					"{S:0.8}({S:0.8,V:1}lvl.#2#{S:0.8}){} Level up",
					"{C:attention}#1#",
					"{C:mult}+#3#{} Mult and",
					"{C:chips}+#4#{} chips",
}
    },
    
	config = { hand_type = "garb_str_four", softlock = true },
	pos = { x = 4, y = 1 },
	atlas = "GarbConsumables",
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				localize("garb_str_four", "poker_hands"),
				G.GAME.hands["garb_str_four"].level,
				G.GAME.hands["garb_str_four"].l_mult,
				G.GAME.hands["garb_str_four"].l_chips,
				colours = {
					(
						(to_big(G.GAME.hands["garb_str_four"].level) == to_big(1)) and G.C.UI.TEXT_DARK
					),
				},
			},
		}
	end,
  },

  SMODS.Consumable{
    key = "lolar",
	  set = "Planet",
    loc_txt = {
      name = 'LOLAR',
      text = {
					"{S:0.8}({S:0.8,V:1}lvl.#2#{S:0.8}){} Level up",
					"{C:attention}#1#",
					"{C:mult}+#3#{} Mult and",
					"{C:chips}+#4#{} chips",
}
    },
    
	config = { hand_type = "garb_str_five", softlock = true },
	pos = { x = 0, y = 2 },
	atlas = "GarbConsumables",
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				localize("garb_str_five", "poker_hands"),
				G.GAME.hands["garb_str_five"].level,
				G.GAME.hands["garb_str_five"].l_mult,
				G.GAME.hands["garb_str_five"].l_chips,
				colours = {
					(
						(to_big(G.GAME.hands["garb_str_five"].level) == to_big(1)) and G.C.UI.TEXT_DARK
					),
				},
			},
		}
	end,
  },


    SMODS.Consumable{
    key = "lofaf",
	  set = "Planet",
    loc_txt = {
      name = 'LOFAF',
      text = {
					"{S:0.8}({S:0.8,V:1}lvl.#2#{S:0.8}){} Level up",
					"{C:attention}#1#",
					"{C:mult}+#3#{} Mult and",
					"{C:chips}+#4#{} chips",
}
    },
    
	config = { hand_type = "garb_str_fl_house", softlock = true },
	pos = { x = 1, y = 2 },
	atlas = "GarbConsumables",
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				localize("garb_str_fl_house", "poker_hands"),
				G.GAME.hands["garb_str_fl_house"].level,
				G.GAME.hands["garb_str_fl_house"].l_mult,
				G.GAME.hands["garb_str_fl_house"].l_chips,
				colours = {
					(
						(to_big(G.GAME.hands["garb_str_fl_house"].level) == to_big(1)) and G.C.UI.TEXT_DARK
					),
				},
			},
		}
	end,
  },

    SMODS.Consumable{
    key = "skaia",
	  set = "Planet",
    loc_txt = {
      name = 'Skaia',
      text = {
					"{S:0.8}({S:0.8,V:1}lvl.#2#{S:0.8}){} Level up",
					"{C:attention}#1#",
					"{C:mult}+#3#{} Mult and",
					"{C:chips}+#4#{} chips",
}
    },
    
	config = { hand_type = "garb_str_fl_five", softlock = true },
	pos = { x = 2, y = 2 },
	atlas = "GarbConsumables",
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				localize("garb_str_fl_five", "poker_hands"),
				G.GAME.hands["garb_str_fl_five"].level,
				G.GAME.hands["garb_str_fl_five"].l_mult,
				G.GAME.hands["garb_str_fl_five"].l_chips,
				colours = {
					(
						(to_big(G.GAME.hands["garb_str_fl_five"].level) == to_big(1)) and G.C.UI.TEXT_DARK
					),
				},
			},
		}
	end,
  },


-- MISC CONSUMABLES

  SMODS.Consumable{
    key = 'hope',
    set = 'Tarot',
    loc_txt = {
      name = 'Hope',
      text = {
        "Enhances {C:attention}#1#{}",
        "selected cards to",
        "{C:attention}#2#s"
}
    },
  
    atlas = 'GarbConsumables', pos = { x = 0, y = 1 },
  
      config = {extra = { max_highlighted = 2, enhancement = "Pure Card" }},
      
      loc_vars = function(self, info_queue, card)
          info_queue[#info_queue+1] = G.P_CENTERS.m_garb_pure
          if next(find_joker("j_garb_scopacane")) then
            info_queue[#info_queue+1] = {set = "Other", key = "mega_enhance", specific_vars = {card.ability.extra.max_highlighted, card.ability.extra.enhancement}}
            end      
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
          conversionTarot(G.hand.highlighted, 'm_garb_pure')    
          delay(0.6)
          return true
    end
  },

    SMODS.Consumable{
    key = 'adjustment',
    set = 'Tarot',
    loc_txt = {
      name = 'Adjustment',
      text = {
        "Enhances {C:attention}#1#{} selected",
        "card into a",
        "{C:attention}#2#"
}
    },
  
    atlas = 'GarbConsumables', pos = { x = 1, y = 1 },
  
      config = {extra = { max_highlighted = 1, enhancement = "Royal Card" }},
      
      loc_vars = function(self, info_queue, card)
          info_queue[#info_queue+1] = G.P_CENTERS.m_garb_royal
          if next(find_joker("j_garb_scopacane")) then
            info_queue[#info_queue+1] = {set = "Other", key = "mega_enhance", specific_vars = {card.ability.extra.max_highlighted, card.ability.extra.enhancement}}
            end      
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
          conversionTarot(G.hand.highlighted, 'm_garb_royal')    
          delay(0.6)
          return true
    end
  },

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
          if next(find_joker("j_garb_scopacane")) then
            info_queue[#info_queue+1] = {set = "Other", key = "mega_enhance", specific_vars = {card.ability.extra.max_highlighted, card.ability.extra.enhancement}}
            end      
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
    key = 'art',
    set = 'Tarot',
    loc_txt = {
      name = 'Art',
      text = {
        "Enhances {C:attention}#1#{} selected",
        "card into a",
        "{C:attention}#2#"
}
    },
  
    atlas = 'GarbConsumables', pos = { x = 2, y = 1 },
  
      config = {extra = { max_highlighted = 1, enhancement = "Jump Card" }},
      
      loc_vars = function(self, info_queue, card)
          info_queue[#info_queue+1] = G.P_CENTERS.m_garb_jump
          if next(find_joker("j_garb_scopacane")) then
            info_queue[#info_queue+1] = {set = "Other", key = "mega_enhance", specific_vars = {card.ability.extra.max_highlighted, card.ability.extra.enhancement}}
            end      
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
          conversionTarot(G.hand.highlighted, 'm_garb_jump')    
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
        local new_card = copy_card(G.jokers.highlighted[1], nil, nil, nil, true)
        new_card:set_edition('e_negative', true)
        new_card:add_to_deck()
        G.jokers:emplace(new_card)
        card:juice_up(0.3, 0.5)
        return true end }))
      delay(0.6)
      return true
    end
  }
  
}