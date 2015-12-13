warp = require 'nexus-warp'
vo   = require 'vo'
Nightmare = require 'nightmare'

SessionManager = require './session-manager'

Sandbox = require './facets/sandbox/sandbox'
GameSession = require './game-session'
{GameSessionModel} = require './common/models/game-session'

class Service

	start: (http_server) ->

		@sandbox = new Sandbox

		@game_sessions = null
		GameSessionModel
			.find {}
			.populate 'puzzles'
			.exec (err, sessions) =>
				@game_sessions = new Map sessions.map (session) =>
					[
						do session._id.toString,
						new GameSession session, @sandbox
					]


		new warp.Service
			transport:         new warp.WebSocketTransport
				http_server:     http_server
				session_manager: new SessionManager @

		vo(->
			nightmare = do Nightmare
			yield nightmare
				.goto 'http://localhost:3000/sandbox.html'
		) (err, result) -> console.log 'cssqd-service:ready'

module.exports = Service
