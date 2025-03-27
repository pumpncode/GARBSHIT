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
    })
}