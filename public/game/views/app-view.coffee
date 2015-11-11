AppView = (context) ->
	nxt.Element 'div',
		nxt.Binding context.round_phase, nxt.Text

module.exports = AppView
