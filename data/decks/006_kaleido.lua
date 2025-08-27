return {
 SMODS.Back {
        key = 'kaleido',
        config = {},
        atlas = 'GarbDecks',
        pos = { x = 2, y = 1 },    
        unlocked = false,
        discovered = false,
        config = { },
        loc_vars = function(self, info_queue, card)
            return {vars = {pseudorandom_element(G.KaleidoQuips,pseudoseed('lols'))}}
        end,
        apply = function(self, back)
            G.E_MANAGER:add_event(Event({
                func = function()
                    if G.jokers then
                        local card = create_card("Joker", G.jokers, false, "garb_rainbow", nil, nil, nil, "gay")
                        card:add_to_deck()
                        card:start_materialize()
                        G.jokers:emplace(card)
                        return true
                    end
                end,
            }))
            end,
        check_for_unlock = function(self, args)
                if args.type == "kaleido_deck" then
                  return true
                end
              end,    
    },

    }