warp = require 'nexus-warp'
vo   = require 'vo'
Nightmare = require 'nightmare'

Sandbox = require './facets/sandbox/sandbox'
SessionManager = require './session-manager'

class Service

	start: (http_server) ->

		@sandbox = new Sandbox

		new warp.Service
			transport: new warp.WebSocketTransport
				http_server: http_server
				session_manager: new SessionManager @
			entities:
				player_selector: @sandbox.selector
				player_match: @sandbox.match

		vo(->
			nightmare = do Nightmare
			yield nightmare
				.goto 'http://localhost:3000/sandbox.html'
		) (err, result) -> console.log err, result

module.exports = Service
