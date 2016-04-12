SelectorMatchResult = require 'cssqd-shared/models/selector-match-result'

MatchRendererView       = (require 'common/components/match-renderer').View
UserPanelView           = (require 'common/components/user-panel').View
TimespanView            = (require 'common/components/timespan').View
OccurrenceIndicatorView = (require 'common/components/occurrence-indicator').View

RoundPhase = require 'cssqd-shared/models/round-phase'

GameView = (context) ->
	nxt.Element 'div',
		nxt.Class 'game-screen'

		UserPanelView context.userPanelViewModel

		nxt.Element 'div',
			nxt.Class 'game-screen-container'

			nxt.Element 'div',
				nxt.Text 'thread'

			nxt.Element 'div',
				nxt.Class 'levels-info'

				nxt.Element 'p',
					nxt.Class 'levels-info-num'
					nxt.Binding context.puzzle, (puzzle) ->
						if puzzle?
							nxt.Text "Level #{puzzle.index + 1}:"

				nxt.Element 'p',
					nxt.Class 'levels-info-name'
					nxt.Binding context.puzzle, (puzzle) ->
						if puzzle?
							nxt.Text 'PUZZLE NAME STUB'

			nxt.Element 'div',
				nxt.Class 'controls'

				nxt.Binding context.puzzle, (puzzle) ->
					if puzzle?.banned_characters.length
						nxt.Element 'div',
							nxt.Class 'controls-selector-banned-container'
							nxt.Text 'Banned characters'
							OccurrenceIndicatorView context.occurrenceIndicator

				nxt.Binding context.round_phase, (phase) ->
					if phase is RoundPhase.IN_PROGRESS
						nxt.Element 'input',
							nxt.Class 'controls-selector-input'
							nxt.Event 'input', context.selector, (event) -> event.target.value
							nxt.Attr 'placeholder', 'Enter your selector here...'
							nxt.Attr 'maxlength', context.SELECTOR_MAX_LENGTH
							nxt.Focus yes
							nxt.Binding context.puzzle_solved, (isSolved) ->
								nxt.Attr 'disabled' if isSolved

				nxt.Binding context.puzzle_solved, (isSolved) ->
					if isSolved
						nxt.Element 'div',
							nxt.Class 'success-marker'
							nxt.Text '✓'
					else
						TimespanView context.roundTimerViewModel

			MatchRendererView context.matchRenderer

			nxt.Binding context.puzzle_solved, (isSolved) ->
				if isSolved
					nxt.Element 'div',
						nxt.Class 'success-overlay'
							nxt.Element 'div',
								nxt.Class 'success-message'
								nxt.Text 'Done!'

module.exports = GameView
