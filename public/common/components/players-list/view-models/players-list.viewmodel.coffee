Functor = require 'cssqd-shared/nx/cell-functor'
CounterCommand = require 'cssqd-shared/nx/counter-command'

class PlayersListViewModel

	constructor: (@players) ->
		@solvedCount = Functor
			cell:
				value: 0
			map:
				'<-': [
					@players.transform.change
					({ value: {correct} }) ->
						if correct
							CounterCommand.INCREASE
						else
							CounterCommand.RETAIN
				]


module.exports = PlayersListViewModel
