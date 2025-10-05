return {
 SMODS.Joker {
      key = 'blank',
      loc_txt = {
        name = 'Blank Joker',
        text = {
            "{C:inactive}Does nothing?"
          },
      },
      config = { extra = {  } },
      loc_vars = function(self, info_queue, card)
        local returntable = {vars = {} }
        local key, vars
        returntable.key =  card.antimattered and (self.key .. "_alt") or self.key
        return returntable
      end,
      rarity = "garb_rainbow",
      atlas = 'GarbJokers',
      pos = {x = 4, y = 11},
      cost = 10,
      
        unlocked = true, 
        discovered = false, --whether or not it starts discovered
        blueprint_compat = true, --can it be blueprinted/brainstormed/other
        eternal_compat = false, --can it be eternal
        perishable_compat = false, --can it be perishable
  
      update = function(self,card,dt)
        card.antimattered = card.antimattered or (card.area == G.jokers) and (G.GAME.round_resets.ante > 8)
      end,

      calculate = function(self, card, context)
        if context.setting_blind and card.antimattered then
              local create_champion_event = function()
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.8,
                    func = function()
                        if G.hand_text_area.blind_chips then
                            local new_chips = math.floor(G.GAME.blind.chips + G.GAME.blind.chips * (#G.jokers.cards/100))
                            local mod_text = number_format(
                                math.floor(G.GAME.blind.chips * (#G.jokers.cards/100))
                            )
                            G.GAME.blind.chips = new_chips
                            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
    
                            local chips_UI = G.hand_text_area.blind_chips
                            G.FUNCS.blind_chip_UI_scale(G.hand_text_area.blind_chips)
                            G.HUD_blind:recalculate()
    
                            attention_text({
                                text = mod_text,
                                scale = 0.8,
                                hold = 0.7,
                                cover = chips_UI.parent,
                                cover_colour = G.C.RED,
                                align = 'cm'
                            })
    
                            chips_UI:juice_up()
    
                            play_sound('chips2')
                        else
                        return false --create_champion_event()
                        end
                        return true
                    end
                }))
            end
            create_champion_event()
        end

        if context.ante_end and G.GAME.round_resets.ante == 8 then
          card:set_edition("e_negative")
          old_limit = G.jokers.config.card_limit
          G.jokers.config.card_limit = 99
        end
      end,

      remove_from_deck = function(self, card, from_debuff)
        G.jokers.config.card_limit = old_limit or G.jokers.config.card_limit
      end
    },
  
  }