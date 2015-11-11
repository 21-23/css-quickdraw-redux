{nx} = require 'nexus-node'

{PuzzleModel} = require './common/models/puzzle'
RoundPhase    = require './common/models/round-phase'

class GameSession

	constructor: ({@sandbox, puzzles}) ->
		@puzzles = new nx.Cell value:puzzles

		@round_phase = new nx.Cell
			value: RoundPhase.WAIT_SCREEN

		@current_puzzle_index = new nx.Cell

		@puzzle = new nx.Cell
			'->': [@sandbox.puzzle_data]

		@selector = new nx.Cell
			'->': [@sandbox.selector]

		@match = new nx.Cell
			'<-': [@sandbox.match]

module.exports = GameSession
