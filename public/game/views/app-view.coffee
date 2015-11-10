AppView = (context) ->
	nxt.Element 'input',
		nxt.ValueBinding context.selector

module.exports = AppView
