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
				(selector) =>
					puzzle = @puzzle.value
					puzzle.match selector
			]

module.exports = Sandbox
