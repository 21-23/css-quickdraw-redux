PearlView = require './pearl.view.coffee'

PearlsView = (context) ->
	nxt.Element 'div',
		nxt.Class 'qd-pearl-thread'
		context.pearls.map PearlView

module.exports = PearlsView
