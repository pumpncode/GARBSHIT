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
            name = 'Matesprit',
            description = {
              "5 Heart cards"
            }
        }
    },
    visible = false,
    evaluate = function(parts, hand)
        if next(parts._flush) and next(find_joker("j_garb_shipping")) and SHIPPINGWALL_HAND == "Matesprit" then
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
            name = 'Kismesis',
            description = {
              "5 Spade cards"
            }
        }
    },
    visible = false,
    evaluate = function(parts, hand)
        if next(parts._flush) and next(find_joker("j_garb_shipping")) and SHIPPINGWALL_HAND == "Kismesis" then
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
            name = 'Auspistice',
            description = {
              "5 Club cards"
            }
        }
    },
    visible = false,
    evaluate = function(parts, hand)
        if next(parts._flush) and next(find_joker("j_garb_shipping")) and SHIPPINGWALL_HAND == "Auspistice" then
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
            name = 'Moirail',
            description = {
              "5 Diamond cards"
            }
        }
    },
    visible = false,
    evaluate = function(parts, hand)
        if next(parts._flush) and next(find_joker("j_garb_shipping")) and SHIPPINGWALL_HAND == "Moirail" then
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