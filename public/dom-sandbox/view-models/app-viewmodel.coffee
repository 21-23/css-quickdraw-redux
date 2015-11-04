warp = require 'nexus-warp'

Sandbox = require '../models/sandbox/sandbox'

class AppViewModel

	constructor: ->

		@sandbox = new Sandbox

		new warp.Client
			transport: new warp.WebSocketTransport address:"ws://#{window.location.host}"
			entities:
				puzzle_data: @sandbox.puzzle_data
				selector:    @sandbox.selector
				match:       @sandbox.match

module.exports = AppViewModel
