require '../styles/button.styl'

ButtonView = (context) ->
	nxt.Element 'div',
		nxt.Class 'button'
		nxt.Text context.text
		nxt.Event 'click', context.click

module.exports = ButtonView
