SMODS.Atlas({
	key = "yurilatro",
	path = "yurilatro.png",
	px = 71,
	py = 95,
})

SMODS.Joker({
	key = "j_yaoi",
	loc_txt = {
		name = "yaoi",
		text = {
			"Gives {X:mult,C:white}x#1#{} Mult per played",
			"{C:attention}King{} or {C:attention}Jack{} in your"
			"scoring hand if played hand",
			"contains a {C:attention}pair{} of either.",
		},
	},

	config = { extra = { X_mult = 1 } },

	rarity = 3,

	atlas = "yurilatro",
	pos = { x = 1, y = 0 },

	cost = 8,

	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xmult } }
	end,

	calculate = function(self, card, context)
		if context.joker_main then
			if context.poker_hands["Pair"] then
				local pairs_exist = false
				for _, pair in ipairs(context.poker_hands["Pair"]) do
					if pairs_exist then
						break
					end
					for k, v in ipairs(pair) do
						if v:get_id() == 11 or v:get_id() == 13 then
							pairs_exist = true
							break
						end
					end
				end
				if pairs_exist then
					local cumulative = 1
					for k, v in ipairs(context.scoring_hand) do
						if v:get_id() == 11 or v:get_id() == 13 then
							cumulative = cumulative + 1
						end
					end
					return {
						message = localize({
							type = "variable",
							key = "a_xmult",
							vars = { card.ability.extra.Xmult * cumulative },
						}),
						Xmult_mod = card.ability.extra.Xmult * cumulative,
					}
				end
			end
		end
	end,
})

SMODS.Joker({
	key = "j_yuri",
	loc_txt = {
		name = "yuri",
		text = {
			"Gives {X:mult,C:white}x#1#{} Mult per played",
			"{C:attention}Queen{} in scoring hand if",
			"it contains a {C:attention}Pair{}of {C:attention}Queens{}.",
		},
	},

	config = { extra = { X_mult = 1 } },

	rarity = 3,

	atlas = "yurilatro",
	pos = { x = 0, y = 0 },

	cost = 8,

	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xmult } }
	end,

	calculate = function(self, card, context)
		if context.joker_main then
			if context.poker_hands["Pair"] then
				local pairs_exist = false
				for _, pair in ipairs(context.poker_hands["Pair"]) do
					if pairs_exist then
						break
					end
					for k, v in ipairs(pair) do
						if v:get_id() == 12 then
							pairs_exist = true
							break
						end
					end
				end
				if pairs_exist then
					local cumulative = 1
					for k, v in ipairs(context.scoring_hand) do
						if v:get_id() == 12 then
							cumulative = cumulative + 1
						end
					end
					return {
						message = localize({
							type = "variable",
							key = "a_xmult",
							vars = { card.ability.extra.Xmult * cumulative },
						}),
						Xmult_mod = card.ability.extra.Xmult * cumulative,
					}
				end
			end
		end
	end,
})
