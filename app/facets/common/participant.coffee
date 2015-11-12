{nx} = require 'nexus-node'

class Participant

	constructor: (@service) ->
		@game_session = new nx.Cell
		@game_session_id = new nx.Cell
			'->': [
				@game_session,
				(id) =>	@service.game_sessions.get id
			]

		@round_phase = @game_session.flatten ({round_phase}) -> round_phase
		@puzzles = @game_session.flatten ({puzzles}) -> puzzles
		@current_puzzle_index = @game_session.flatten ({current_puzzle_index}) ->
			current_puzzle_index
		@node_list = @game_session.flatten ({node_list}) -> node_list
		@countdown = @game_session.flatten ({countdown}) -> countdown.remaining

module.exports = Participant
