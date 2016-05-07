require '../styles/players-list.styl'
{ formatMSS } = (require '../../../utils/date-time-utils')

PlayersListView = (context) ->
	nxt.Element 'div',
		nxt.Class 'players-scores-list'

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

			nxt.Binding context.scores, (scores = []) ->
				nxt.Fragment scores.map ({name, score}, rating) ->
					nxt.Element 'div',
						nxt.Class 'item'

						nxt.Element 'div',
							nxt.Class '-name'
							nxt.Text name
						nxt.Element 'div',
							nxt.Class '-time'
							nxt.Text "#{formatMSS score}"

module.exports = PlayersListView
