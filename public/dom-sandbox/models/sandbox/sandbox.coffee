{nx} = require 'nexus'

Puzzle = require '../puzzle/puzzle'

class Sandbox

	constructor: ->
		@puzzle_data = new nx.Cell

		@puzzle = new nx.Cell
			'<-': [@puzzle_data, (data) -> new Puzzle data]

		@selector = new nx.Cell
		@match = new nx.Cell
			'<-': [
				@selector,
				({selector, player_id}) =>
					puzzle = @puzzle.value
					time = do performance.now
					match = puzzle.match selector
					match.player_id = player_id
					match.time = performance.now() - time
					match
			]

		@node_list = new nx.Cell
			'<-': [@puzzle, ({tags}) -> tags]

module.exports = Sandbox
