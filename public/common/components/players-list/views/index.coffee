require '../styles/players-list.styl'
TimespanViewModel = (require '../../timespan').ViewModel

PlayersListView = (context) ->
	nxt.Element 'table',
		nxt.Class 'players-list-table'
		nxt.Element 'thead',
			nxt.Element 'tr',
				nxt.Element 'th',
					nxt.Class 'col-player-name'
					nxt.Text 'Player Name'
				nxt.Element 'th',
					nxt.Class 'col-player-time'
					nxt.Text 'Time'
				nxt.Element 'th',
					nxt.Class 'col-player-length'
					nxt.Text 'Length'
		nxt.Element 'tbody',
			nxt.Collection context.players, (player) ->
				nxt.Element 'tr',
					nxt.Binding player.solution, (solution) ->
						if solution?.correct
							nxt.Class 'row-player-correct'
					nxt.Element 'td',
						nxt.Text player.display_name
					nxt.Element 'td',
						nxt.Class 'cell-player-time'
						nxt.Binding player.solution, (solution) ->
							if solution?
								nxt.Text TimespanViewModel.prototype.formatMSS solution.time
					nxt.Element 'td',
						nxt.Class 'cell-player-length'
						nxt.Binding player.solution, (solution) ->
							if solution?
								nxt.Text solution.selector.length

module.exports = PlayersListView
