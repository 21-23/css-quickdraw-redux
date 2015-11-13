{nx} = require 'nexus-node'

class Participant

	constructor: (@service) ->
		@game_session = new nx.Cell

		@round_phase = new nx.Cell
			'<<-*': [@game_session, 'round_phase']

		@puzzles = new nx.Cell
			'<<-*': [@game_session, 'puzzles']

		@current_puzzle_index = new nx.Cell
			'->*': [@game_session, 'current_puzzle_index']

		@node_list = new nx.Cell
			'<<-*': [@game_session, 'node_list']

		@countdown = new nx.Cell
			'<<-*': [@game_session, ({countdown: {remaining}}) -> remaining]

		@game_session_id = new nx.Cell
			'->': [@game_session, (id) =>	@service.game_sessions.get id]

module.exports = Participant
