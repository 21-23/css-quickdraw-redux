warp   = require 'nexus-warp'
co     = require 'co'
bunyan = require 'bunyan'

{ APP_BASE_URL } = require 'cssqd-config/constants'

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

		logger = bunyan.createLogger
			name: 'cssqd-warp'
			streams: [
				path: "#{__dirname}/../cssqd-warp-log.json"
			]

		@log = ({type, session, data}) ->
			logger.info
				type: type
				user_id: session.facet.participant?.id or 'sandbox'
				data: data

		logger.info 'service-start'
		new warp.Service
			transport:         new warp.WebSocketTransport
				http_server:     http_server
				session_manager: new SessionManager @
			log: @log

module.exports = Service
