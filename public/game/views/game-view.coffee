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
				nxt.Class 'controls'

				nxt.Element 'div',
					nxt.Class 'qd-pearl-thread'
					nxt.Text 'pearl thread'

				nxt.Binding context.puzzle, (puzzle) ->
					if puzzle?.banned_characters.length
						nxt.Element 'div',
							nxt.Class 'controls-selector-banned-container'
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
							nxt.Focus yes
							# nxt.Binding context.match, (match) ->
							# 	nxt.Attr 'disabled' if match?.result is SelectorMatchResult.POSITIVE

				TimespanView context.roundTimerViewModel

			MatchRendererView context.matchRenderer

module.exports = GameView
