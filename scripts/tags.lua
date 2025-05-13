return {
    SMODS.Tag {
        key = 'mail',
        loc_txt = {
          name = 'Mail Tag',
          text = {
            "Gives a free",
            "{C:stamp}Mega Postal Pack"
        }
        },
        atlas = 'GarbTags', 
        pos = { x = 0, y = 0 },
        in_pool = function()
		    return (G.GAME.round_resets.ante > 1)
	    end,
        apply = function(self, tag, context)
              if context.type == "new_blind_choice" then
                  tag:yep("+", G.C.ATTENTION, function()
                      local key = "p_garb_stamp_booster_m"
                      local card = Card(
                          G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2,
                          G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2,
                          G.CARD_W * 1.27,
                          G.CARD_H * 1.27,
                          G.P_CARDS.empty,
                          G.P_CENTERS[key],
                          { bypass_discovery_center = true, bypass_discovery_ui = true }
                      )
                      card.cost = 0
                      card.from_tag = true
                      G.FUNCS.use_card({ config = { ref_table = card } })
                      card:start_materialize()
                      return true
                  end)
                  tag.triggered = true
                  return true
              end
          end,
      },
      
    SMODS.Tag {
        key = 'carnival',
        loc_txt = {
          name = 'Carnival Tag',
          text = {
            "Shop has a {C:attention}duplicate{}",
            "of one of your",
            "{C:attention}non-legendary{} Jokers"
        }
        },
        atlas = 'GarbTags', 
        pos = { x = 1, y = 0 },
        in_pool = function()
		    return (G.GAME.round_resets.ante > 1)
	    end,
        apply = function(self, tag, context)
		if context.type == "store_joker_create" then
            local keys = {}
            if G.jokers then
                for k, v in pairs(G.jokers.cards) do
                    if v.ability.set == 'Joker' and not (type(v.config.center.rarity) == "number" and v.config.center.rarity >= 4) then
                        table.insert(keys, v.config.center.key)
                    end
                end  
            end
            if not keys[1] then return false end
			local card
            local curKey = pseudorandom_element(keys, pseudoseed('JohnBalatro')) or "j_joker"
			card = create_card("Joker", context.area, nil, nil, nil, nil, curKey)
			create_shop_card_ui(card, "Joker", context.area)
			card.states.visible = false
			tag:yep("+", G.C.RED, function()
				card:start_materialize()
				card:set_cost()
				return true
			end)
			tag.triggered = true
			return card
		end
          end,
      }

}