{nx} = require 'nexus-node'

class Player

	constructor: (@participant) ->
		@selector = new nx.Cell
			'->*': [
				@participant.game_session,
				'selector',
				(selector) =>
					selector: selector
					player_id: @participant.id
			]

		@match = new nx.Cell

	get_entities: ->
		round_phase: @participant.round_phase
		node_list:   @participant.node_list
		countdown:   @participant.countdown

		selector: @selector
		match:    @match



module.exports = Player
