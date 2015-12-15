class Round

	constructor: (status, solution) ->
		@status = new nx.Cell value:status
		@solution = new nx.Cell value:solution

module.exports = Round
