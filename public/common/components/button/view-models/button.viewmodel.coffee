noop = ->

class ButtonViewModel
	constructor: ({ text, clickHandler }) ->
		@text = text
		@onClick = if typeof clickHandler is 'function' then clickHandler else noop

module.exports = ButtonViewModel
