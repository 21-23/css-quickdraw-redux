TimespanView 						= (require 'common/components/timespan').View
UserPanelView           = (require 'common/components/user-panel').View
PuzzlesProgress = (require 'common/components/puzzles-progress').View

CountdownView = (context) ->
	nxt.Element 'div',
		nxt.Class 'game-countdown'

		UserPanelView context.userPanelViewModel

		nxt.Element 'div',
			nxt.Class 'game-countdown-container'

			PuzzlesProgress context.puzzlesProgressViewModel

			nxt.Element 'div',
				nxt.Class 'levels-info'

				nxt.Element 'span',
					nxt.Class 'levels-info-num'
					nxt.Binding context.puzzle, (puzzle) ->
						if puzzle?
							nxt.Text "##{puzzle.index + 1}"

				nxt.Element 'span',
					nxt.Class 'levels-info-name'
					nxt.Binding context.puzzle, (puzzle) -> nxt.Text puzzle?.name or "Puzzle #{puzzle?.index}"

			nxt.Element 'div',
				nxt.Class 'controls'

				nxt.Element 'div',
					nxt.Class 'controls-selector-banned-container'
					nxt.Text 'Banned characters'

				nxt.Element 'input',
					nxt.Class 'controls-selector-input'
					nxt.Attr 'placeholder', 'Enter your selector here...'
					nxt.Attr 'disabled'

				nxt.Element 'div',
					nxt.Class 'controls-timer-stub'

			TimespanView context.countdownViewModel

module.exports = CountdownView
