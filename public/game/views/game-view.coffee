MatchRendererView = (require '../../common/components/match-renderer').View

GameView = (context) ->
	nxt.Element 'div',
		nxt.Element 'input',
			nxt.ValueBinding context.selector

		nxt.Element 'div',
			nxt.Binding context.match, (match) ->
				nxt.Text JSON.stringify match
			MatchRendererView context.matchRendererViewModel

module.exports = GameView
