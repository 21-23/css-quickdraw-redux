require '../styles/players-list.styl'
{ formatMSS } = (require '../../../utils/date-time-utils')

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
					nxt.Binding context.totalCount, nxt.Text
				nxt.Element 'div',
					nxt.Class 'text'
					nxt.Text 'Joined'

			nxt.Element 'div',
				nxt.Class '-passed'
				nxt.Class 'sub-meta'
				nxt.Element 'div',
					nxt.Class 'amount'
					nxt.Binding context.passedCount, nxt.Text
				nxt.Element 'div',
					nxt.Class 'text'
					nxt.Text 'Passed'

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
							if solution?
								nxt.Text formatMSS solution.time

module.exports = PlayersListView
