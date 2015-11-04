warp = require 'nexus-warp'

class AppViewModel
	constructor: ->

		@selector = new nx.Cell
		@match = new nx.Cell

		new warp.Client
			transport: new warp.WebSocketTransport address:"ws://#{window.location.host}"
			entities:
				selector: @selector
				match:    @match

module.exports = AppViewModel
