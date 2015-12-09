GameView = (context) ->
	nxt.Element 'div',
		nxt.Element 'input',
			nxt.ValueBinding context.selector

		nxt.Element 'div',
			nxt.Binding context.match, (match) ->
				nxt.Text JSON.stringify match

module.exports = GameView
