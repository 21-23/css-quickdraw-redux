require '../styles/user-panel.styl'

UserPanelView = (context) ->
	nxt.Element 'div',
		nxt.Class 'user-panel'

		nxt.Element 'div',
			nxt.Class 'logo'
			nxt.Text 'CSS Quick Draw'

		nxt.Element 'div',
			nxt.Class 'user-info'
			nxt.Binding context.name, nxt.Text

		nxt.Element 'div',
			nxt.Class 'log-out'
			nxt.Text 'L'

module.exports = UserPanelView
