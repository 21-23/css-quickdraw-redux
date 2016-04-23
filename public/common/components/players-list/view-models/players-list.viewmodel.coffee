class UserPanelViewModel
	constructor: (@players) ->
		@totalCount = new nx.Cell
			'<-': [
				@players,
				(players) -> if players? then players.length else 0
			]

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


module.exports = UserPanelViewModel
