return {

-- POKER HANDS

SMODS.PokerHand {
    key = 'blush',
    chips = 50,
    mult = 6,
    l_chips = 40,
    l_mult = 3,
    example = {
        { 'H_A',    true },
        { 'H_5',    true },
        { 'H_4',    true },
        { 'H_J',    true },
        { 'H_3',    true },
    },
    loc_txt = {
        ['en-us'] = {
            name = 'Blush Flush',
            description = {
              "5 cards of heart suit"
            }
        }
    },
    visible = false,
    evaluate = function(parts, hand)
        if next(parts._flush) and next(find_joker("j_garb_matesprit")) then
            local royal = true
            local _flosh = SMODS.merge_lists(parts._flush)
            for j = 1, #_flosh do
                royal = royal and _flosh[j]:is_suit('Hearts')
            end
            if royal then return {_flosh} end
        end
    end,
  },
  
  SMODS.PokerHand {
    key = 'caliginous',
    chips = 50,
    mult = 6,
    l_chips = 40,
    l_mult = 3,
    example = {
        { 'S_A',    true },
        { 'S_5',    true },
        { 'S_4',    true },
        { 'S_J',    true },
        { 'S_3',    true },
    },
    loc_txt = {
        ['en-us'] = {
            name = 'Caliginous Quarrel',
            description = {
              "5 cards of spade suit"
            }
        }
    },
    visible = false,
    evaluate = function(parts, hand)
        if next(parts._flush) and next(find_joker("j_garb_kismesis")) then
            local royal = true
            local _flosh = SMODS.merge_lists(parts._flush)
            for j = 1, #_flosh do
                royal = royal and _flosh[j]:is_suit('Spades')
            end
            if royal then return {_flosh} end
        end
    end,
  },
  
  SMODS.PokerHand {
    key = 'ashen',
    chips = 50,
    mult = 6,
    l_chips = 40,
    l_mult = 3,
    example = {
        { 'C_A',    true },
        { 'C_5',    true },
        { 'C_4',    true },
        { 'C_J',    true },
        { 'C_3',    true },
    },
    loc_txt = {
        ['en-us'] = {
            name = 'Ashen Resolution',
            description = {
              "5 cards of club suit"
            }
        }
    },
    visible = false,
    evaluate = function(parts, hand)
        if next(parts._flush) and next(find_joker("j_garb_auspistice")) then
            local royal = true
            local _flosh = SMODS.merge_lists(parts._flush)
            for j = 1, #_flosh do
                royal = royal and _flosh[j]:is_suit('Clubs')
            end
            if royal then return {_flosh} end
        end
    end,
  },
  
  SMODS.PokerHand {
    key = 'pale',
    chips = 50,
    mult = 6,
    l_chips = 40,
    l_mult = 3,
    example = {
        { 'D_A',    true },
        { 'D_5',    true },
        { 'D_4',    true },
        { 'D_J',    true },
        { 'D_3',    true },
    },
    loc_txt = {
        ['en-us'] = {
            name = 'Pale Allegiance',
            description = {
              "5 cards of diamond suit"
            }
        }
    },
    visible = false,
    evaluate = function(parts, hand)
        if next(parts._flush) and next(find_joker("j_garb_moirail")) then
            local royal = true
            local _flosh = SMODS.merge_lists(parts._flush)
            for j = 1, #_flosh do
                royal = royal and _flosh[j]:is_suit('Diamonds')
            end
            if royal then return {_flosh} end
        end
    end,
  },
    
}