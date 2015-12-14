{nx} = require 'nexus-node'

RoundStatus = require 'cssqd-shared/models/round-status'

class Round

	constructor: ->
		@solution = new nx.Cell
		@status = new nx.Cell
			value: RoundStatus.SOLVING
			'<-': [
				@solution
				(solution) ->
					if solution?
						RoundStatus.SOLVED
					else
						RoundStatus.SOLVING
			]

	to_json: ->
		solution: @solution.value
		status:   @status.value

module.exports = Round
