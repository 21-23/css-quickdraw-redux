{nx} = require 'nexus-node'

class Player

	constructor: (@participant) ->
		@participant.selector = new nx.Cell
			'->*': [
				@participant.game_session,
				'selector',
				(selector) =>
					selector: selector
					player_id: do @participant.id.toString
			]

		@participant.match = new nx.Cell

	get_entities: ->
		round_phase: @participant.round_phase
		node_list:   @participant.node_list
		countdown:   @participant.countdown

		selector: @participant.selector
		match:    @participant.match

module.exports = Player
