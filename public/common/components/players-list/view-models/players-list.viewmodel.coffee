class PlayersListViewModel
	constructor: (@players) ->
		#temporary not working
		@passedCount = new nx.Cell
			'<-': [
				@players,
				(players) ->
					if players?
						players.filter((player) -> player.solution?.correct).length
					else
						0
			]


module.exports = PlayersListViewModel
