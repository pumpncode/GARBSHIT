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
                    func = (function()
                        add_tag(Tag('tag_garb_rainbow'))
                        return true
                    end)}))
            end,
        check_for_unlock = function(self, args)
                if args.type == "kaleido_deck" then
                  return true
                end
              end,    
    },

    }