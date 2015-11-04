warp = require 'nexus-warp'
vo   = require 'vo'
Nightmare = require 'nightmare'

SessionManager = require './session-manager'

Sandbox = require './facets/sandbox/sandbox'
GameSession = require './facets/game/game-session'

class Service

	start: (http_server) ->

		@sandbox = new Sandbox
		@game_session = new GameSession
			sandbox: @sandbox

		new warp.Service
			transport:         new warp.WebSocketTransport
				http_server:     http_server
				session_manager: new SessionManager @

		vo(->
			nightmare = do Nightmare
			yield nightmare
				.goto 'http://localhost:3000/sandbox.html'
		) (err, result) -> console.log "Nightmare.js: #{err}, #{result}"

module.exports = Service
