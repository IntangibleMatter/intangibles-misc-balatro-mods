SMODS.Atlas({
	key = "intangible",
	path = "intangible_jokers.png",
	px = 71,
	py = 95,
})

SMODS.Joker({
	key = "j_hexadecimal",
	lox_txt = {
		name = "Hexadecimal",
		text = {
			"Each played {C:attention}#1#{} gives",
			"{C:mult}+#2#{} mult when scored.",
		},
	},

	config = { extra = { rank = 10, mult = 16 } },

	rarity = 2,

	atlas = "intangible",

	pos = { x = 0, y = 0 },

	cost = 8,

	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.rank, card.ability.extra.mult } }
	end,

	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if context.other_card:get_id() == card.ability.extra.rank then
				return {
					mult = card.ability.extra.mult,
					message = localize({
						type = "variable",
						key = "a_mult",
						vars = { card.ability.extra.mult },
						mult_mod = card.ability.extra.mult,
					}),
				}
			end
		end
	end,
})
