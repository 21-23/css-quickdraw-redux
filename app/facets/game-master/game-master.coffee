{nx} = require 'nexus-node'

Participant = require '../common/participant'

class GameMaster extends Participant

	constructor: (service) ->
		super service

		@puzzles = new nx.Cell
			'<<-*': [@game_session, 'puzzles']

		@current_puzzle_index = new nx.Cell
			'->*': [@game_session, 'current_puzzle_index']


module.exports = GameMaster
