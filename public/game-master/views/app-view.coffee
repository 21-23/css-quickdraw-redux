AppView = (context) ->
	nxt.Element 'div',
		nxt.Class 'game-master-screen'

		nxt.Element 'div',
			nxt.Class 'user-panel'
			nxt.Text 'user panel'

		nxt.Element 'div',
			nxt.Class 'game-master-screen-container'
				
				nxt.Binding context.puzzles, (puzzles) ->
					nxt.Element 'div',
						nxt.Class 'qd-pearl-thread'
						puzzles?.map (puzzle, index) ->
							nxt.Element 'div',
								nxt.Text puzzle.name
								nxt.Event 'click', context.current_puzzle_index, -> index

			nxt.Element 'div',
				nxt.Class 'master-controls-container'

				nxt.Element 'div',
					nxt.Class 'players-list'

					nxt.Element 'table',
						nxt.Element 'thead',
							nxt.Element 'tr',
								nxt.Element 'th',
									nxt.Text 'Player Name'
								nxt.Element 'th',
									nxt.Text 'Time'
								nxt.Element 'th',
									nxt.Text 'Length'
						nxt.Element 'tbody',
							nxt.Collection context.players, (player) ->
								nxt.Element 'tr',
									nxt.Element 'td',
										nxt.Text player.displayName
									nxt.Element 'td',
										nxt.Text '0:27'
									nxt.Element 'td',
										nxt.Text '4'

				nxt.Element 'div',
					nxt.Class 'master-controls'

					nxt.Element 'div',
						nxt.Class 'master-controls-timings'

						nxt.Element 'div',
							nxt.Class 'round-title'
							nxt.Binding context.round_phase, nxt.Text
						nxt.Element 'div',
							nxt.Class 'round-timer'
							nxt.Binding context.countdown, nxt.Text

					nxt.Element 'div',
						nxt.Class 'master-controls-gameplay'

						nxt.Element 'div',
							nxt.Class 'start'
							nxt.Text 'Start'
						nxt.Element 'div',
							nxt.Class 'stop'
							nxt.Text 'Stop'
						nxt.Element 'div',
							nxt.Class 'next'
							nxt.Text 'Next'

					nxt.Element 'div',
						nxt.Class 'master-controls-solution-container'

						nxt.Element 'span',
							nxt.Text 'Solution: '
						nxt.Element 'span'

					nxt.Element 'div',
						nxt.Class 'controls-selector-banned-container'
						nxt.Text 'banned chars'

					nxt.Element 'div',
						nxt.Class 'master-controls-puzzle'
						nxt.Text 'HTML GOES HERE'

module.exports = AppView
