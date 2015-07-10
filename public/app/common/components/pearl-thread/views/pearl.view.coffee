PearlView = (context) ->
	nxt.Element 'div',
		nxt.Class 'qd-pearl'
		nxt.Binding context.text, nxt.Text
		nxt.Binding context.modifier, nxt.Class

module.exports = PearlView
