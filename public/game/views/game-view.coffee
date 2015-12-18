MatchRendererView = (require '../../common/components/match-renderer').View
UserPanelView = (require 'common/components/user-panel').View
TimerView = (require 'common/components/timer').View

GameView = (context) ->
	nxt.Element 'div',
		nxt.Class 'game-screen'

		UserPanelView context.userPanelViewModel

		nxt.Element 'div',
			nxt.Class 'game-screen-container'

			nxt.Element 'div',
				nxt.Class 'qd-pearl-thread'
				nxt.Text 'pear thread'

			nxt.Element 'div',
				nxt.Class 'controls'

				nxt.Element 'div',
					nxt.Class 'controls-selector'

					nxt.Element 'div',
						nxt.Class 'controls-selector-banned-container'
						nxt.Text 'banned chars'

					nxt.Element 'input',
						nxt.Class 'controls-selector-input'
						nxt.ValueBinding context.selector
						nxt.Attr 'placeholder', 'Enter your selector here...'

				TimerView context.roundTimerViewModel

			MatchRendererView context.matchRendererViewModel

module.exports = GameView
