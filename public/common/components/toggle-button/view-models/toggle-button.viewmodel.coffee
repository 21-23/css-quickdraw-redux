class ButtonViewModel
	constructor: (@text, defaultValue) ->
		@value = new nx.Cell value: !!defaultValue

	click: =>
		@value.value = not @value.value

module.exports = ButtonViewModel
