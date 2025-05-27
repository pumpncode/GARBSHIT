if not Partner_API then return false else return
{
    Partner_API.Partner{
    key = "jimmy",
    name = "Jimmy",
    unlocked = true,
    discovered = true,
    no_quips = true,
    pos = {x = 0, y = 1},
    loc_txt = {},
    atlas = "GarbPartner",
    config = {extra = {related_card = "j_garb_Jim", money = 2, created = 6, limit = 6, benefits = 1}},
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.money*card.ability.extra.benefits, card.ability.extra.limit} }
    end,
    update = function(self, card)
        card.ability.extra.benefits = next(SMODS.find_card(card.ability.extra.related_card)) and 2 or 1
    end,
    calculate = function(self, card, context)
        if context.partner_main then
          return {
            mult = 4
          }
        end

        if context.partner_click then
          G.GAME.jimmies = G.GAME.jimmies or {}
          local _card = Card(G.deck.T.x+G.deck.T.w-G.CARD_W*0.6, G.deck.T.y-G.CARD_H*1.6, G.CARD_W*46/71, G.CARD_H*58/95, G.P_CARDS.empty, G.P_CENTERS.pnr_garb_jimmy)
          table.insert(G.GAME.jimmies, _card)
        end
    end,
}

}
end