AppView = (context) ->
	nxt.Element 'div',
		nxt.Element 'div',
			nxt.Binding context.round_phase, nxt.Text
		nxt.Element 'div',
			nxt.Binding context.countdown, nxt.Text
		nxt.Element 'input',
			nxt.ValueBinding context.selector
		nxt.Element 'div',
			nxt.Binding context.match, (match) ->
				nxt.Text match?.result

module.exports = AppView
