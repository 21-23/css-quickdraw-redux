MatchRendererView = (require '../../common/components/match-renderer').View

GameView = (context) ->
	nxt.Element 'div',
		nxt.Class 'game-screen'

		nxt.Element 'div',
			nxt.Class 'user-panel'
			nxt.Text 'user panel'

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

				nxt.Element 'div',
					nxt.Class 'controls-timer'
					nxt.Text '0:99'

			MatchRendererView context.matchRendererViewModel

module.exports = GameView
