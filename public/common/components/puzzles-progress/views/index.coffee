require '../styles/puzzles-progress.styl'

PuzzlesProgressView = (context) ->
	nxt.Element 'div',
		nxt.Class 'puzzles-progress'

		nxt.Element 'div',
			nxt.Class 'puzzles-progress-bar'
			nxt.Binding context.complete_percentage, (percent) ->
				nxt.Style width: "#{percent}%"

		nxt.Element 'div',
			nxt.Class 'puzzles-progress-indicators'
			nxt.Binding context.puzzles_change, ([puzzles, current_index]) ->
				nxt.Fragment puzzles.map (puzzle, index) ->
					nxt.Element 'div',
						nxt.Class 'puzzles-progress-indicator'
						nxt.Class context.getPuzzleClass index, current_index
						nxt.Event 'click', context.select, -> index

						nxt.Element 'div',
							nxt.Class 'puzzles-progress-indicator-content'
							nxt.Text context.getPuzzleText index, current_index, puzzle

module.exports = PuzzlesProgressView
