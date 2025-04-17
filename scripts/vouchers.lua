return {
SMODS.Voucher{
    key = 'postcard',
    loc_txt = {
      name = 'Postcard',
      text = {
        "{C:stamp}Stamp{} cards can",
        "be purchased",
        "from the {C:attention}shop"
    }
    },
      atlas = 'GarbVouchers', pos = { x = 0, y = 0 },
      redeem = function(self, card)
        G.GAME.stamp_rate = (G.GAME.stamp_rate or 0) + 4
      end
  },

SMODS.Voucher{
    key = 'guano',
    loc_txt = {
      name = 'Postal Service',
      text = {
        "{C:stamp}Stamp{} cards appear",
        "{C:attention}#1#X{} more frequently",
        "in the shop"
    }
    },
      atlas = 'GarbVouchers', pos = { x = 1, y = 0 },
      config = {extra = {odds = 2}},
      requires = {"v_garb_postcard"},

      loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.odds }}
    end,


      redeem = function(self, card)
        G.GAME.stamp_rate = (G.GAME.stamp_rate or 0) * card.ability.extra.odds
      end
  },

}