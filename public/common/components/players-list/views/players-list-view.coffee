require '../styles/players-list.styl'
{ formatMSS } = require '../../../utils/date-time-utils'

PlayersListView = (context) ->
	nxt.Element 'div',
		nxt.Class 'players-list'

		nxt.Element 'div',
			nxt.Class 'players-list-meta'

			nxt.Element 'div',
				nxt.Class '-total'
				nxt.Class 'sub-meta'
				nxt.Element 'div',
					nxt.Class 'amount'
					nxt.Binding context.players.length, nxt.Text
				nxt.Element 'div',
					nxt.Class 'text'
					nxt.Text 'Joined'

			nxt.Element 'div',
				nxt.Class '-passed'
				nxt.Class 'sub-meta'
				nxt.Element 'div',
					nxt.Class 'amount'
					nxt.Binding context.solvedCount, nxt.Text
				nxt.Element 'div',
					nxt.Class 'text'
					nxt.Text 'Solved'

		nxt.Element 'div',
			nxt.Class 'players-list-table'

			nxt.Element 'div',
				nxt.Class 'header'
				nxt.Element 'div',
					nxt.Class '-name'
					nxt.Text 'Player Name'
				nxt.Element 'div',
					nxt.Class '-time'
					nxt.Text 'Time'
				nxt.Element 'div',
					nxt.Class '-length'
					nxt.Text 'Length'

			#TODO: make an abstract rendering component and re-use for agregate score list
			nxt.Collection context.players, (player) ->
				nxt.Element 'div',
					nxt.Class 'item'
					nxt.Binding player.solution, (solution) ->
						if solution?.correct
							nxt.Class '-passed'

					nxt.Element 'div',
						nxt.Class '-name'
						nxt.Text player.display_name
					nxt.Element 'div',
						nxt.Class '-time'
						nxt.Binding player.solution, (solution) ->
							if solution?.correct
								nxt.Text formatMSS solution.time
					nxt.Element 'div',
						nxt.Class '-length'
						nxt.Binding player.solution, (solution) ->
							if solution?.selector?
								nxt.Text solution.selector.length

module.exports = PlayersListView
