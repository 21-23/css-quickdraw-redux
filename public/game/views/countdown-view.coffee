TimespanView 						= (require 'common/components/timespan').View
UserPanelView           = (require 'common/components/user-panel').View

CountdownView = (context) ->
	nxt.Element 'div',
		nxt.Class 'game-countdown'

		UserPanelView context.userPanelViewModel

		nxt.Element 'div',
			nxt.Class 'game-countdown-container'

			nxt.Element 'div',
				nxt.Class 'levels-info'

				nxt.Element 'p',
					nxt.Class 'levels-info-num'
					nxt.Binding context.puzzle, (puzzle) ->
						if puzzle?
							nxt.Text "Level #{puzzle.index + 1}:"

				nxt.Element 'p',
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

			TimespanView context.countdownViewModel

module.exports = CountdownView
