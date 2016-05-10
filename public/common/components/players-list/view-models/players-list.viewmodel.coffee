Functor = require 'cssqd-shared/nx/cell-functor'
CounterCommand = require 'cssqd-shared/nx/counter-command'

class PlayersListViewModel

	constructor: (@players) ->
		@solvedCount = new nx.Cell
			'<-': [
				[ @players.transform.change, @players.length ],
				(change, length) =>
					@players.value.reduce \
						((solved, player) ->
							if player.solution.value?.correct then (solved + 1) else solved),
						0
			]

module.exports = PlayersListViewModel
