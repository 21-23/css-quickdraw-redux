WaitScreenView = (context) ->
	nxt.Element 'div',
		nxt.Class 'game-wait-screen-container'

		nxt.Element 'h1',
			nxt.Class 'game-wait-screen-header'
			nxt.Text 'Keep calm, cowboy'

		nxt.Element 'h2',
			nxt.Class 'game-wait-screen-sub-header'
			nxt.Text 'We\'r waiting for others'

module.exports = WaitScreenView
