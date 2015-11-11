{nx} = require 'nexus-node'

class GameMaster

	constructor: (@service) ->
		@game_session = new nx.Cell
		@game_session_id = new nx.Cell
			'->': [
				@game_session,
				(id) =>	@service.game_sessions.get id
			]

		@round_phase = @game_session.flatten ({round_phase}) -> round_phase

module.exports = GameMaster
