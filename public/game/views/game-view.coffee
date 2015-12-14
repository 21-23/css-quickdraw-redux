MatchRendererView = (require '../../common/components/match-renderer').View

GameView = (context) ->
	nxt.Element 'div',
		nxt.Element 'input',
			nxt.ValueBinding context.selector

		MatchRendererView context.matchRendererViewModel

module.exports = GameView
