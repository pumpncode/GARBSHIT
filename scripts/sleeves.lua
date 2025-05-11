return {
    CardSleeves.Sleeve {
        key = "tangerine",
        atlas = "GarbSleeves",  -- you will need to create an atlas yourself
        pos = { x = 0, y = 0 },
        loc_vars = function(self)
            local key, vars
            if self.get_current_deck_key() == "b_garb_garbdeck" then
                key = self.key .. "_alt"
            end
            return { key = key }
        end,    
        unlocked = false,
        unlock_condition = {deck = "b_garb_garbdeck", stake = "stake_black"},

    },

    CardSleeves.Sleeve {
        key = "albert",
        atlas = "GarbSleeves",  -- you will need to create an atlas yourself
        pos = { x = 1, y = 0 },
        config = { ante_scaling = 1.5, hands = -1},
        loc_vars = function(self)
            local key, vars
            if self.get_current_deck_key() == "b_garb_albert" then
                key = self.key .. "_alt"
                self.config.hands = -1
                G.GAME.starting_params.hands = G.GAME.starting_params.hands + self.config.hands
            else
                self.config.hands = 0
                G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling * self.config.ante_scaling
            end
            vars = {self.config.ante_scaling, self.config.hands}
            return { key = key, vars = vars }
        end,   
        unlocked = false,
        unlock_condition = {deck = "b_garb_albert", stake = "stake_black"},
 
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
    },

    CardSleeves.Sleeve {
        key = "cycle",
        atlas = "GarbSleeves",  -- you will need to create an atlas yourself
        pos = { x = 3, y = 0 },
        config = { money = 75, ante = 1 },
        loc_vars = function(self)
            local key, vars
            if self.get_current_deck_key() == "b_garb_cycle" then
                key = self.key .. "_alt"
                self.config.money = 150
            else
                self.config.money = 75
            end
            vars = {self.config.money}
            return { key = key, vars = vars }
        end,  
        unlocked = false,
        unlock_condition = {deck = "b_garb_cycle", stake = "stake_black"},

        apply = function(self, back)
            self.config.ante = 1
            G.E_MANAGER:add_event(Event({
                func = function()
                    if self.get_current_deck_key() ~= "b_garb_cycle" then
                        play_sound('garb_snap', 1)
                    end
                    ease_dollars(self.config.money-G.GAME.dollars, true)
                    return true
                end
            }))
        end,

        calculate = function(self, card, context)
            if G.GAME.round_resets.ante ~= self.config.ante and context.starting_shop and self.get_current_deck_key() ~= "b_garb_cycle" then
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

            elseif G.GAME.round_resets.ante ~= self.config.ante and context.starting_shop and self.get_current_deck_key() == "b_garb_cycle" then
                for k, v in pairs(G.GAME.hands) do
                    if G.GAME.hands[k].level > 1 then
                        G.GAME.hands[k].level = 1
                    end
                end
                self.config.ante = G.GAME.round_resets.ante
                ease_dollars(self.config.money-G.GAME.dollars, true)
            end     
        end,
    },

    CardSleeves.Sleeve {
        key = "doodle",
        atlas = "GarbSleeves",  -- you will need to create an atlas yourself
        pos = { x = 2, y = 0 },
        config = {
            vouchers = {
                'v_garb_postcard',
            },
            consumables = {
                "c_garb_mascot"
            }
        },
        unlocked = false,
        unlock_condition = {deck = "b_garb_doodle", stake = "stake_black"},

        loc_vars = function(self)
            local key, vars
            if self.get_current_deck_key() == "b_garb_doodle" then
                vars = {localize{type = 'name_text', key = 'v_garb_guano', set = 'Voucher'}, localize{type = 'name_text', key = 'c_garb_mascot', set = 'Stamp'}}
                self.config.consumables = {}
                self.config.vouchers = { "v_garb_guano" }
                key = self.key .. "_alt"
            else
                vars = {localize{type = 'name_text', key = 'v_garb_postcard', set = 'Voucher'}, localize{type = 'name_text', key = 'c_garb_mascot', set = 'Stamp'}}
                self.config.vouchers = { "v_garb_postcard" }
                self.config.consumables = { "c_garb_mascot" }
            end
            return { key = key, vars = vars }
        end,    
    },

    CardSleeves.Sleeve {
        key = "byss",
        atlas = "GarbSleeves",  -- you will need to create an atlas yourself
        pos = { x = 0, y = 1 },
        config = {
            slots = 1
        },
        loc_vars = function(self)
            local key, vars
            vars = {self.config.slots}
            if self.get_current_deck_key() == "b_garb_byss" then
                key = self.key .. "_alt"
            else
                key = self.key
            end
            return { key = key, vars = vars }
        end,    
        apply = function(self, back)
            G.GAME.starting_params.joker_slots = 1
        end,
        calculate = function(self,card,context)
            if context.end_of_round and G.GAME.blind.boss and not context.individual and not context.repetition and self.get_current_deck_key() ~= "b_garb_byss" then
                G.jokers.config.card_limit = G.jokers.config.card_limit + 1
                play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                play_sound('garb_bisso')    
                card_eval_status_text(G.jokers, 'extra', nil, nil, nil, {message = "+1 Slots!", colour = G.C.DARK_EDITION})
            elseif context.end_of_round and G.GAME.blind.boss and not context.individual and not context.repetition and self.get_current_deck_key() == "b_garb_byss" then
                G.hand.config.card_limit = G.hand.config.card_limit + 1
                card_eval_status_text(G.hand, 'extra', nil, nil, nil, {message = "+1 Size!", colour = G.C.DARK_EDITION})                    
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

    },

}