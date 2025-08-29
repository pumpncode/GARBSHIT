----------------------------------------------
------------MOD CODE -------------------------

local mod = SMODS.current_mod
config = mod.config
garb_enabled = copy_table(config)

function jimboReturned()
if pseudorandom('ohheyitsthegun') > 0.80 and G.GAME.objectivelysold and ( #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit) then
    local new_card = SMODS.create_card{key = "j_garb_objectively", no_edition = true}
    new_card:add_to_deck()
    G.jokers:emplace(new_card)
    new_card:start_materialize()
    play_sound('timpani')
    play_sound('garb_ping')
    card_eval_status_text(new_card, "extra", nil, nil, nil, {message = "!!"})
    G.GAME.objectivelysold = false
end
end

local drawhook = love.draw
function love.draw()
    drawhook()
    if blackout then
        love.graphics.setColor(0, 0, 0, 1)
        love.graphics.rectangle("fill", -1000,-1000, 5000,5000)
    end
end

local function garb_batch_load(txt) 
    local joker_files = NFS.getDirectoryItems(mod.path.."data/"..txt)
    sendInfoMessage(mod.path.."data/"..txt)
    local txt = txt..'/'
    for _, file in pairs(joker_files) do
        sendInfoMessage(file)
        if string.find(file, ".lua") then
          assert(SMODS.load_file("data/"..txt..file))()
        end
    end
    sendInfoMessage("FINISHED BATCH LOAD FOR "..txt)
    return true
end

to_big = to_big or function(x, y)
  return x
end

SMODS.current_mod.optional_features = function()
  return { cardareas = { discard = true, deck = true } }
end

local function config_matching()
	for k, v in pairs(garb_enabled) do
		if v ~= config[k] then
			return false
		end
	end
	return true
end

function G.FUNCS.garb_restart()
	if config_matching() then
		SMODS.full_restart = 0
	else
		SMODS.full_restart = 1
	end
end

SMODS.current_mod.config_tab = function()
  garb_nodes = {{n=G.UIT.R, config={align = "cm"}, nodes={{n=G.UIT.O, config={object = DynaText({string = "Options:", colours = {G.C.WHITE}, shadow = true, scale = 0.4})}},
  }},create_toggle({label = "Teto Joker Music (Fukkireta)", ref_table = config, ref_value = "fukkireta",
  }),create_toggle({label = "Old Teto Sprite (Requires Restart)", ref_table = config, ref_value = "oldteto", callback = G.FUNCS.garb_restart
  }),create_toggle({label = "Custom Title Screen (Requires Restart)", ref_table = config, ref_value = "title", callback = G.FUNCS.garb_restart, 
  }),create_toggle({label = "On-Card Credits", ref_table = config, ref_value = "on_card_credits"
  }),create_toggle({label = "Gay Poker Hands (Requires Restart)", ref_table = config, ref_value = "gay", callback = G.FUNCS.garb_restart
  }),create_toggle({label = "GARBSHIT Repainted (Requires Restart)", ref_table = config, ref_value = "repainted", callback = G.FUNCS.garb_restart
  })

}
  return {
    n = G.UIT.ROOT,
    config = {
        emboss = 0.05,
        minh = 6,
        r = 0.1,
        minw = 10,
        align = "cm",
        padding = 0.2,
        colour = G.C.BLACK
    },
    nodes = garb_nodes
  }  
end

function card_transform(card, key)
  G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() card:flip();play_sound('card1');card:juice_up(0.3, 0.3);return true end }))
  G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
  card:remove_from_deck()
  if G.P_CENTERS[key] then key = key else key = "j_joker" end
  card.config.center = G.P_CENTERS[key]
  card:set_ability(card.config.center.key,true)
  card:add_to_deck()
  return true 
  end}))
  G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() card:flip();play_sound('tarot2');card:juice_up(0.3, 0.3);return true end }))
end

function card_transform_shop(card, key)
  G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() card:flip();play_sound('card1');card:juice_up(0.3, 0.3);return true end }))
  G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
  if G.P_CENTERS[key] then key = key else key = "j_joker" end
  card.config.center = G.P_CENTERS[key]
  card:set_ability(card.config.center.key,true)
  return true 
  end}))
  G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() card:flip();play_sound('tarot2');card:juice_up(0.3, 0.3);return true end }))
end


function get_straight(hand, min_length, skip, wrap)
    min_length = min_length or 5
    if min_length < 2 then min_length = 2 end
    if #hand < min_length then return {} end
    local ranks = {}
    local jumps = {}
    for k,_ in pairs(SMODS.Ranks) do ranks[k] = {} end
    for _,card in ipairs(hand) do
        local id = card:get_id()
        if SMODS.has_enhancement(card, 'm_garb_jump') then
            id = 0
            table.insert(jumps, card)
        end
        if id > 0 then
            for k,v in pairs(SMODS.Ranks) do
                if v.id == id then table.insert(ranks[k], card); break end
            end
        end
    end
    local function next_ranks(key, start)
        local rank = SMODS.Ranks[key]
        local ret = {}
		if not start and not wrap and rank.straight_edge then return ret end
        for _,v in ipairs(rank.next) do
            ret[#ret+1] = v
            if skip and (wrap or not SMODS.Ranks[v].straight_edge) then
                for _,w in ipairs(SMODS.Ranks[v].next) do
                    ret[#ret+1] = w
                end
            end
        end
        return ret
    end
    local tuples = {}
    local ret = {}
    for _,k in ipairs(SMODS.Rank.obj_buffer) do
        if next(ranks[k]) or #jumps >= 1 then
            tuples[#tuples+1] = {k}
            tuples[#tuples].jumps_remaining = #jumps - (next(ranks[k]) and 0 or 1)
        end
    end
    for i = 2, #hand+1 do
        local new_tuples = {}
        for _, tuple in ipairs(tuples) do
            local any_tuple
            if i + tuple.jumps_remaining ~= #hand+1 then
                for _,l in ipairs(next_ranks(tuple[i-1], i == 2)) do
                    if next(ranks[l]) or #jumps >= 1 then
                        local new_tuple = {}
                        new_tuple.jumps_remaining = tuple.jumps_remaining - (next(ranks[l]) and 0 or 1)
                        for _,v in ipairs(tuple) do new_tuple[#new_tuple+1] = v end
                        new_tuple[#new_tuple+1] = l
                        new_tuples[#new_tuples+1] = new_tuple
                        any_tuple = true
                    end
                end
            end
            if i + tuple.jumps_remaining > min_length and not any_tuple then
                local straight = {}
                for _,v in ipairs(tuple) do
                    for _,card in ipairs(ranks[v]) do
                        straight[#straight+1] = card
                    end
                end
                for _, card in ipairs(jumps) do
                    straight[#straight+1] = card
                end
                ret[#ret+1] = straight
            end
        end
        tuples = new_tuples
    end
    table.sort(ret, function(a,b) return #a > #b end)
    return ret
end

create_card_ref = create_card
function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
  local _card = create_card_ref(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
  if _card.config.center.key == "j_garb_zoroark" then
    local evil_pool = get_current_pool('Joker')
    local _key = pseudorandom_element(evil_pool,pseudoseed('zoroark'))
    _card.disguised = "j_garb_zoroark"
    card_transform_shop(_card, _key)
  end
  return _card
end

local draw_ref = Card.draw
function Card:draw(layer)
    if self.config.center.key == 'j_garb_showoff' and (self.edition and self.edition.negative) and self.config.center.discovered then
        self.children.center:set_sprite_pos({x=1,y=9})
    elseif self.config.center.key == 'j_garb_showoff' and self.config.center.discovered then
        self.children.center:set_sprite_pos({x=6,y=7})
    end

    if self.config.center.key == 'j_garb_zoroark' and (self.edition and self.edition.negative) and self.config.center.discovered then
        self.children.center:set_sprite_pos({x=2,y=10})
    elseif self.config.center.key == 'j_garb_zoroark' and self.config.center.discovered then
        self.children.center:set_sprite_pos({x=1,y=10})
    end

    draw_ref(self,layer)
end

local click_ref = Card.click
function Card:click()
  if G.GAME.jimmies then
  for k, v in pairs(G.GAME.jimmies) do
    if v == self then
        if self.children.speech_bubble then
            self:remove_partner_speech_bubble()
        elseif not G.GAME.partner_click_deal then
            G.GAME.partner_click_deal = true
            local ret = v:calculate_partner({partner_click = true})
            if ret then
                SMODS.trigger_effects({{individual = ret}}, v)
            end
            G.E_MANAGER:add_event(Event({func = function()
                G.GAME.partner_click_deal = nil
            return true end}))
        end
    end
  end
end
  click_ref(self)
end

local Rclick_ref = Card.partner_R_click
function Card:partner_R_click()
  if G.GAME.jimmies then
  for k, v in pairs(G.GAME.jimmies) do
    if v == self then
        if not G.GAME.partner_R_click_deal then
	          G.GAME.partner_R_click_deal = true
            local ret = v:calculate_partner({partner_R_click = true})
            if ret then
                SMODS.trigger_effects({{individual = ret}}, v)
            end
            G.E_MANAGER:add_event(Event({func = function()
                G.GAME.partner_R_click_deal = nil
            return true end}))
        end
    end
  end
end
  Rclick_ref(self)
end


local use_consumeable_old = Card.use_consumeable
local quadrant_hands = {"garb_blush", "garb_caliginous", "garb_ashen", "garb_pale"}
function Card:use_consumeable(area, copier)
  for i = 1, #quadrant_hands do
  if self.ability.consumeable.hand_type == "Flush" and SHIPPINGWALL_HAND and localize(quadrant_hands[i], 'poker_hands') == SHIPPINGWALL_HAND then
    update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize(quadrant_hands[i], 'poker_hands'),chips = G.GAME.hands[quadrant_hands[i]].chips, mult = G.GAME.hands[quadrant_hands[i]].mult, level=G.GAME.hands[quadrant_hands[i]].level})
    level_up_hand(self, quadrant_hands[i], nil, 1)
    update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
  elseif self.ability.consumeable.hand_type == "Flush" then
    level_up_hand(self, quadrant_hands[i], true, 1)
  end
  end
  local ret = use_consumeable_old(self)
  return ret
end

function conversionTarot(hand, newcenter)
	--Animation ported from basegame Tarot
  --Hi Unstable devs I love you I ported this code over from your mod, hope you don't mind
	
	for i=1, #hand do
		local percent = 1.15 - (i-0.999)/(#hand-0.998)*0.3
		G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() hand[i]:flip();play_sound('card1', percent);hand[i]:juice_up(0.3, 0.3);return true end }))
	end
	delay(0.2)
	
	--Handle the conversion
	for i=1, #hand do
    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
				hand[i]:set_ability(G.P_CENTERS[newcenter])
				return true end }))
	end
	
	for i=1, #hand do
		local percent = 0.85 + (i-0.999)/(#hand-0.998)*0.3
    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() hand[i]:flip();play_sound('tarot2', percent, 0.6);hand[i]:juice_up(0.3, 0.3);return true end }))
	end
	G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
	delay(0.5)
end

local Getid_old = Card.get_id
function Card:get_id()
  local ret = Getid_old(self)
  if ret == 12 and next(find_joker("j_garb_equality")) then ret = 13 end
  return ret
end


  -- TITLE SCREEN
if config.title and not next(SMODS.find_mod("Cryptid")) then
  SMODS.Atlas({
    key = "balatro",
    path = (config.repainted and "repainted/" or "").."Logo.png",
    px = 333,
    py = 216,
    prefix_config = { key = false }
  })

  function add_card_to_title(use_key)
    local newcard = SMODS.create_card({
        set = "Joker",
        area = G.title_top,
        key = use_key,
        no_edition = true
    })
    -- recenter the title
    newcard:start_materialize({ G.C.WHITE, G.C.SECONDARY_SET.Personality }, true, 2.5)
    G.title_top:emplace(newcard)
    -- make the card look the same way as the title screen Ace of Spades
    newcard.T.scale = 1.32
  newcard.no_ui = true
end 

local main_menu_ref = Game.main_menu
Game.main_menu = function(change_context)
    local ret = main_menu_ref(change_context)
    add_card_to_title("j_garb_garbTITLE")
    G.title_top.T.w = G.title_top.T.w * 1.7675 * 1.2
    G.title_top.T.x = G.title_top.T.x - 0.8 * 1.8
    G.SPLASH_BACK:define_draw_steps({ {
        shader = 'splash',
        send = {
            { name = 'time',       ref_table = G.TIMERS, ref_value = 'REAL_SHADER' },
            { name = 'vort_speed', val = 0.4 },
            { name = 'colour_1',   ref_table = G.C,      ref_value = 'GARB_T2' },
            { name = 'colour_2',   ref_table = G.C,      ref_value = 'GARB_T1' },
        }
    } }) 
    return ret
end
end

SMODS.current_mod.description_loc_vars = function()
  return { background_colour = G.C.CLEAR, text_colour = G.C.WHITE, scale = 1.2 }
end

SMODS.ConsumableType{
    key = 'Stamp',
    primary_colour = HEX("73A557"),
    secondary_colour = HEX("73A557"),
    loc_txt = {
        name = 'Stamp', -- used on card type badges
        collection = 'Stamp Cards', -- label for the button to access the collection
        undiscovered = { -- description for undiscovered cards in the collection
            name = 'Not Discovered',
            text = {
                "Purchase or use",
                "this card in an",
                "unseeded run to",
                "learn what it does"
            }       
        },
    },
    shop_rate = 0.0,
    default = "c_garb_fruit"
}

garb_batch_load("jokers")
garb_batch_load("consumables")
garb_batch_load("boosters")
garb_batch_load("enhancements")
garb_batch_load("decks")
garb_batch_load("tags")
garb_batch_load("vouchers")
garb_batch_load("poker_hands")
garb_batch_load("misc")

if next(SMODS.find_mod("CardSleeves")) then
  garb_batch_load("cross-mod/cardsleeves")
end

if next(SMODS.find_mod("partner")) then
  garb_batch_load("cross-mod/partners")
end

if next(SMODS.find_mod("malverk")) then
  garb_batch_load("cross-mod/malverk")
end