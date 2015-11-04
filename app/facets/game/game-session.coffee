{nx} = require 'nexus-node'

Puzzle = require '../../common/models/puzzle'

class GameSession

	constructor: ({@sandbox}) ->

		@puzzle = new nx.Cell
			'->': [@sandbox.puzzle_data]

		# for now grab just one puzzle
		Puzzle.find
			name: 'Matching Game',
			(err, [puzzle]) => @puzzle.value = puzzle

		@selector = new nx.Cell
			'->': [@sandbox.selector]

		@match = new nx.Cell
			'<-': [@sandbox.match]

module.exports = GameSession
