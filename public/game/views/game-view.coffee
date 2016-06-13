SelectorMatchResult = require 'cssqd-shared/models/selector-match-result'

MatchRendererView       = (require 'common/components/match-renderer').View
UserPanelView           = (require 'common/components/user-panel').View
CountdownCircleView     = (require 'common/components/countdown-circle').View
OccurrenceIndicatorView = (require 'common/components/occurrence-indicator').View
PuzzlesProgress = (require 'common/components/puzzles-progress').View

RoundPhase = require 'cssqd-shared/models/round-phase'

GameView = (context) ->
	nxt.Element 'div',
		nxt.Class 'game-screen'

		UserPanelView context.userPanelViewModel

		nxt.Element 'div',
			nxt.Class 'game-screen-container'

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

				nxt.Binding context.puzzle, (puzzle) ->
					if puzzle?.banned_characters.length
						nxt.Element 'div',
							nxt.Class 'controls-selector-banned-container'
							nxt.Text 'Banned characters'
							OccurrenceIndicatorView context.occurrenceIndicator

				#TODO: move input to a separate component
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
					CountdownCircleView \
						if isSolved
							context.solutionTimerViewModel
						else
							context.roundTimerViewModel

			MatchRendererView context.matchRenderer

module.exports = GameView
