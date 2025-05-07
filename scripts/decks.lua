return {
    -- "borrowed" the lovely patch for this deck from the cardsauce mod, go play it, it's goated
    SMODS.Back({
        key = 'garbdeck',
        config = {},
        atlas = 'GarbDecks',
        pos = { x = 0, y = 0 },    
        unlocked = true,
        discovered = true,
        config = {
            vouchers = {
                'v_overstock_norm',
            },
        },
        loc_vars = function(self, info_queue, card)
            return {vars = {localize{type = 'name_text', key = 'v_overstock_norm', set = 'Voucher'}}}
        end,
        unlock_condition = {type = 'win_deck', deck = 'b_red'}
    }),

    SMODS.Back({
        key = 'albert',
        config = {},
        atlas = 'GarbDecks',
        pos = { x = 1, y = 0 },    
        unlocked = false,
        discovered = false,
        config = { ante_scaling = 1.5},
        loc_vars = function(self, info_queue, card)
            return {vars = {self.config.ante_scaling}}
        end,
        apply = function(self, back)
            G.E_MANAGER:add_event(Event({
                func = function()
                    if G.jokers then
                        local card = create_card("Joker", G.jokers, true, 4, nil, nil, nil, "ALBERT")
                        card:add_to_deck()
                        card:start_materialize()
                        G.jokers:emplace(card)
                        return true
                    end
                end,
            }))
            end,
        check_for_unlock = function(self, args)
                if args.type == "albert_deck" then
                  return true
                end
              end,    
    }),

    SMODS.Back({
        key = 'cycle',
        config = {},
        atlas = 'GarbDecks',
        pos = { x = 0, y = 1 },    
        unlocked = false,
        discovered = true,
        config = {
            money = 75,
            ante = 1
        },
        loc_vars = function(self, info_queue, card)
            return {vars = {self.config.money}}
        end,
        check_for_unlock = function(self, args)
            if args.type == "cycle_deck" then
              return true
            end
          end,    

        apply = function(self, back)
            self.config.ante = 1
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound('garb_snap', 1)
                    ease_dollars(self.config.money-G.GAME.dollars, true)
                    return true
                end
            }))
        end,

        calculate = function(self, card, context)
            if G.GAME.round_resets.ante ~= self.config.ante and context.starting_shop then
                    play_sound('garb_snap', 1)
                    local deletable_jokers = {}
                    ease_dollars(self.config.money-G.GAME.dollars, true)

                    for k, v in pairs(G.jokers.cards) do
                        if not v.ability.eternal then deletable_jokers[#deletable_jokers + 1] = v end
                    end

                    for k, v in pairs(G.consumeables.cards) do
                        v:start_dissolve(nil, _first_dissolve)
                        _first_dissolve = true
                    end
                    
                    for k, v in pairs(deletable_jokers) do
                        if v ~= chosen_joker then 
                            v:start_dissolve(nil, _first_dissolve)
                            _first_dissolve = true
                        end
                    end

                    self.config.ante = G.GAME.round_resets.ante
            end     
        end,
    }),

    SMODS.Back({
        key = 'doodle',
        config = {},
        atlas = 'GarbDecks',
        pos = { x = 2, y = 0 },    
        unlocked = false,
        discovered = true,
        config = {
            vouchers = {
                'v_garb_postcard',
            },
            consumables = {
                "c_garb_mascot"
            }
        },
        loc_vars = function(self, info_queue, card)
            return {vars = {localize{type = 'name_text', key = 'v_garb_postcard', set = 'Voucher'}, localize{type = 'name_text', key = 'c_garb_mascot', set = 'Stamp'}}}
        end,
        unlock_condition = {type = 'win_deck', deck = 'b_garb_garbdeck'},
        check_for_unlock = function(self, args)
            if args.type == "win_deck" then
                if get_deck_win_stake(self.unlock_condition.deck) > 0 then
                    return true
                end
            end          
        end,    
    }),

    SMODS.Back({
        key = 'byss',
        config = {},
        atlas = 'GarbDecks',
        pos = { x = 1, y = 1 },    
        unlocked = false,
        discovered = true,
        config = {
            slots = 1,
            joker_slot = -4
        },
        loc_vars = function(self, info_queue, card)
            return {vars = {self.config.slots}}
        end,
        apply = function(self, back)
            
        end,
        calculate = function(self,card,context)
            if context.end_of_round and G.GAME.blind.boss and not context.individual and not context.repetition then
                G.jokers.config.card_limit = G.jokers.config.card_limit + 1
                play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                play_sound('garb_bisso')    
                card_eval_status_text(G.jokers, 'extra', nil, nil, nil, {message = "+1 Slots!", colour = G.C.DARK_EDITION})                    
            end
        end,
        unlock_condition = {type = 'win_deck', deck = 'b_garb_cycle'},
        check_for_unlock = function(self, args)
            if args.type == "win_deck" then
                if get_deck_win_stake(self.unlock_condition.deck) > 0 then
                    return true
                end
            end          
        end,    
    }),
}