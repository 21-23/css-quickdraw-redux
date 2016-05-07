require '../styles/toggle-button.styl'

ToggleButtonView = (context) ->
	nxt.Element 'div',
		nxt.Class 'toggle-button'
		nxt.Text context.text
		nxt.Event 'click', context.click
		nxt.Binding context.value, (enabled) ->
			nxt.Class '-toggled' if enabled

module.exports = ToggleButtonView
