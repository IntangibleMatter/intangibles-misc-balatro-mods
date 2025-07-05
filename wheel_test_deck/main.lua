SMODS.Atlas({
	key = "atlas_wheedeck",
	path = "wheeldeck.png",
	px = 71,
	py = 95,
})

SMODS.Back({
	name = "Wheel Deck",
	key = "wheeldeck",
	--atlas = "atlas_wheeldeck",
	pos = { x = 0, y = 0 },
	config = { wheeldeck = true },
	loc_txt = {
		name = "Wheel Deck",
		text = {
			"Create a {C:dark_edition}Negative",
			"{C:attention}Wheel of Fortune{} card",
			"after every shop.",
			"Rate: {C:attention}#1#{} / {C:attention}#2#{} ({C:attention}#3#{}%)",
		},
	},
	loc_vars = function(self, info_queue, card)
		attempts = (G.PROFILES[G.SETTINGS.profile].IM_WHEELDECK_wheel_attempts or 0)
		successes = (G.PROFILES[G.SETTINGS.profile].IM_WHEELDECK_wheel_successes or 0)
		return {
			vars = {
				successes,
				attempts,
				(successes / attempts) * 100,
			},
		}
	end,
	calculate = function(self, back, context)
		if context.ending_shop then
			G.E_MANAGER:add_event(Event({
				func = function()
					card = create_card("Tarot", G.consumables, nil, nil, nil, nil, "c_wheel_of_fortune", "wheeldeck")
					card:set_edition("e_negative", true)
					card:add_to_deck()
					G.consumeables:emplace(card)
					return true
				end,
			}))
		end
	end,
})

FlowerPot.addRecord({
	key = "IM_WHEELDECK_wheel_successes",
	add_tooltips = function(self, info_queue, card_progress, card)
		info_queue[#info_queue + 1] = {
			key = "IM_WHEELDECK_wheel_successes",
			set = "Other",
			vars = { to_number(G.PROFILES[G.SETTINGS.profile].IM_WHEELDECK_wheel_successes or self.default) },
		}
	end,
	check_record = function(self, card)
		return (G.PROFILES[G.SETTINGS.profile].IM_WHEELDECK_wheel_successes or 0)
	end,
	default = 0,
})
FlowerPot.addRecord({
	key = "IM_WHEELDECK_wheel_attempts",
	add_tooltips = function(self, info_queue, card_progress, card)
		info_queue[#info_queue + 1] = {
			key = "IM_WHEELDECK_wheel_attempts",
			set = "Other",
			vars = { to_number(G.PROFILES[G.SETTINGS.profile].IM_WHEELDECK_wheel_attempts or self.default) },
		}
	end,
	check_record = function(self, card)
		return (G.PROFILES[G.SETTINGS.profile].IM_WHEELDECK_wheel_attempts or 0)
	end,
	default = 0,
})

--FlowerPot.

-- todo: Create a Function which tracks how often Wheel of Fortune Succeeds.
