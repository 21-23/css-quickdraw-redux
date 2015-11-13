{nx} = require 'nexus-node'

Participant = require '../common/participant'

class Player extends Participant

	constructor: (service) ->
		super service

		@selector = new nx.Cell
			'->*': [
				@game_session,
				'selector',
				(selector) =>
					selector: selector
					player_id: @id
			]

		@match = new nx.Cell

module.exports = Player
