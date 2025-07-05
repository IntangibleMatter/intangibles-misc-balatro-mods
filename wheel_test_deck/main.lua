SMODS.Atlas({
	key = "wheeltest",
	path = "wheeltest.png",
	px = 71,
	py = 95,
})

SMODS.Back({
	name = "Wheel Deck",
	key = "wheeldeck",
	pos = { x = 0, y = 0 },
	config = { wheeldeck = true },
	loc_txt = {
		name = "Wheel Deck",
		text = {
			"Create a {C:dark_edition}Negative {C:Attention}Wheel of Fortune{} card after",
			"every played hand.",
			"{C:Attention}Oops! All Sixes!{} is banned.",
		},
	},
	calculate = function(self, back, context)
		if context == "final_scoring_step" then
			G.E_MANAGER:add_event(Event({
				func = function()
					-- pseudorandom_element is a vanilla function that chooses a single random value from a table of values, which in this case, is your consumables.
					-- pseudoseed('perkeo2') could be replaced with any text string at all - It's simply a way to make sure that it's affected by the game seed, because if you use math.random(), a base Lua function, then it'll generate things truly randomly, and can't be reproduced with the same Balatro seed. LocalThunk likes to have the joker names in the pseudoseed string, so you'll often find people do the same.
					local card =
						create_card("Tarot", G.consumables, nil, nil, nil, nil, "c_wheel_of_fortune", "wheeldeck")

					-- Vanilla function, it's (edition, immediate, silent), so this is ({edition = 'e_negative'}, immediate = true, silent = nil)
					card:set_edition("e_negative", true)
					card:add_to_deck()
					-- card:emplace puts a card in a cardarea, this one is G.consumeables, but G.jokers works, and custom card areas could also work.
					-- I think playing cards use "create_playing_card()" and are separate.
					G.consumeables:emplace(card)
					return true
				end,
			}))
		end
	end,
})

-- todo: Create a Function which tracks how often Wheel of Fortune Succeeds.
