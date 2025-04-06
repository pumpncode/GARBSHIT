return {
    descriptions = {
        Enhanced = {
			m_garb_infected = {
				name = "Infected Card",
				text = {
					"{C:green}#1# in #2#{} chance to infect adjacent",
                    "cards while this card stays in hand",
					"{C:red}Self-destructs{} after {C:attention}#3#{} rounds",
				},
			},
            m_garb_pure = {
				name = "Pure Card",
				text = {
					"Can't be debuffed"
				},
			},
        },

        Other = {
            p_garb_stamp_booster = {
                name = "Postal Pack",
                text = {
                    "Choose {C:attention}#1#{} of",
                    "up to {C:attention}#2# Stamps{}",
                },
            },       

            p_garb_stamp_booster_2 = {
                name = "Postal Pack",
                text = {
                    "Choose {C:attention}#1#{} of",
                    "up to {C:attention}#2# Stamps{}",
                },
            },

            p_garb_stamp_booster_j = {
                name = "Jumbo Postal Pack",
                text = {
                    "Choose {C:attention}#1#{} of",
                    "up to {C:attention}#2# Stamps{}",
                },
            },

            p_garb_stamp_booster_m = {
                name = "Mega Postal Pack",
                text = {
                    "Choose {C:attention}#1#{} of",
                    "up to {C:attention}#2# Stamps{}",
                },
            },            
            
            lamborghiniofficial = {
                name = "Credits",
                text = {
                    "Art and idea by",
                    "{E:1,C:attention}lamborghiniofficial"
                }
            }, 
     
            talisman_warning = {
                name = "WARNING!",
                text = {
                    "This Joker is {C:red}incompatible{} with the {C:attention}Talisman{} mod!",
                    "When bought, it will instantly {C:red}destroy{} itself",
                    "to avoid potential crashes"
                }
            },
            quadrant_hands = {
                name = "Quadrant Hand",
                text = {
                    "{C:attention}#1#{} levels up", 
                    "when using {C:planet}Jupiter{}",
                    "{C:mult}+3{} Mult and",
                    "{C:chips}+40{} chips"
                }
            },
            mega_fool = {
                name = "True Arcana",
                text = {
                    "Creates two {C:dark_edition}Negative{} copies",
                    "of last {C:tarot}Tarot{} or {C:planet}Planet{}",
                    "card used during this run",
                    "{s:0.8,C:tarot}The Fool{s:0.8} excluded"
                }
            },
                mega_hermit = {
                    name = "True Arcana",
                    text = {
                        "Doubles money",
                        "{C:inactive}(Max of {C:money}$50{C:inactive})"
                    }
            },
            mega_temperance = {
                name = "True Arcana",
                text = {
                    "Gives the total sell",
                    "value of all current",
                    "Jokers {C:inactive}(No Max Amount)",
                    "{C:inactive}(Currently {C:money}$#2#{C:inactive})"
                }
            },
            mega_enhance = {
                name = "True Arcana",
                text = {
                    "Enhances all",
                    "scored cards to",
                    "{C:attention}#2#s"
                }
            },
            mega_suiters = {
            name = "True Arcana",
            text = {
                "Converts all",
                "cards {C:attention}held in hand{}",
                "to {V:1}#2#{}"
            }
            },
            mega_priestess = {
                name = "True Arcana",
                text = {
                    "Creates a free",
                    "{C:planet}Meteor Tag"
                }
            },

            mega_emperor = {
            name = "True Arcana",
            text = {
                "Creates up to 2",
                "random {C:dark_edition}Negative{} {C:tarot}Tarot{}",
                "cards"
            }
            },
            mega_judgement = {
            name = "True Arcana",
            text = {
                "Creates a random",
                "{C:dark_edition}Polychrome{} or {C:dark_edition}Negative{}",
                "{C:attention}Joker{} card",
                "{C:inactive}(Must have room)"
            }
            },

            mega_hangedman = {
                name = "True Arcana",
                text = {
                    "Destroys all cards",
                    "{C:attention}held in hand{}"
                }
                },

            mega_strength = {
                name = "True Arcana",
                text = {
                    "Converts all scored",
                    "{C:attention}number{} cards",
                    "to {C:attention}10{}, and all scored",
                    "{C:attention}face{} cards to {C:attention}Kings{}"
                }
                },

            mega_wheel_of_fortune = {
                name = "True Arcana",
                text = {
                    "{C:green}#1# in 2{} chance to add",
                    "{C:dark_edition}Polychrome{} or {C:dark_edition}Negative{}",
                    "to a random {C:attention}Joker"
                }
                },

            mega_death = {
                name = "True Arcana",
                text = {
                    "Out of {C:attention}scored hand{},",
                    "convert the {C:attention}2 leftmost{} cards",
                    "into the {C:attention}rightmost{} card"
                }
                },        
        },

    Back = {
            b_garb_garbdeck = {
                name = "Tangerine Deck",
                text = {
                    "{C:attention}GARBSHIT{} Jokers appear",
                    "{C:attention}3x{} more often",
                    "Start run with {C:attention,T:v_overstock_norm}#1#{}",
                },
            },
            b_garb_albert = {
                name = "Albert's Deck",
                text = {
                    "Start run with a",
                    "{E:1,C:legendary}Legendary{} Joker",
                    "{C:red}X#1#{} base Blind size",
                },
                unlock = {
                    "Use a {C:stamp,T:c_garb_vintage}Vintage Stamp{} on",
                    "a {E:1,C:legendary}Legendary{} Joker"
                }
            },
            b_garb_doodle = {
                name = "Doodle Deck",
                text = {
                    "Start run with the",
                    "{C:stamp,T:v_garb_postcard}#1#{} voucher",
                    "and a {C:stamp,T:c_garb_mascot}#2#{} card"
                },
            },
        },
    
    
    Mod = 
    {
        GARBPACK = {
            name = "GARBSHIT",
            text = {
                "A silly vanilla-friendly mod made by {C:attention,E:1}garb{}",
                " ",
                "{s:1.5,C:attention,E:2}Credits:",
                "{C:dark_edition,E:2}garb{} - Lead, Art, Code",
                " ",
                "{s:1.25,C:attention,E:2}Joker Contributions:",
                "{C:dark_edition,E:2}lamborghiniofficial{} - Backtrack",
                " ",
                "{s:1.5,C:attention,E:2}Also Try:",
                "{C:dark_edition,E:1}Rofflatro, Victin's Collection, Aikoyori's Shenanigans{}",
                "{C:dark_edition,E:1}Revo's Vault{}",
                " ",
                "{s:0.9}Special thanks to the {C:attention,s:0.9}Balatro Discord!{}"
            }
        }
    },

},
    misc = {
        achievement_names = {
            ach_garb_regicide = "Regicide!",
            ach_garb_corr_upgrade = "Upgraded!",
            ach_garb_neverpunished = "Never punished",
            ach_garb_criticalfail = "Critical Fail",
            ach_garb_surged = "SURGED!",
            ach_garb_rocking = "You Got Me Rocking",
            ach_garb_snowedin = "Snowed In",
            ach_garb_jimboss = "JIMBO MUST DIE",
        },
        achievement_descriptions = {
            ach_garb_regicide = "Guillotine the Baron",
            ach_garb_corr_upgrade = "Have Corrupted Joker give 100 Chips or more",
            ach_garb_neverpunished = "While using Sara, play 5 Glass cards on any hand that isn't the first and have none of them break",
            ach_garb_criticalfail = "While using Critical Roll, play 5 Lucky cards and have none of them trigger",
            ach_garb_surged = "Have your Jokers destroyed by THE SURGE",
            ach_garb_rocking = "Create 25 Stone cards in the same run using Rolling Stone",
            ach_garb_snowedin = "Have Snowball give more than 5000 Chips at once",
            ach_garb_jimboss = "Defeat Jimboss 5 times in the same run",
        },
        dictionary = {
            stamp_booster = "Postal Pack",
            ph_mr_bones = "Saved by Joker effect",
        }
    },
}
