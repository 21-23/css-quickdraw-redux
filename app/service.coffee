{nx}   = require 'nexus-node'
warp   = require 'nexus-warp'
co     = require 'co'
bunyan = require 'bunyan'

{ APP_BASE_URL } = require 'cssqd-config/constants'

{GameSessionModel} = require './common/models/game-session'
{PuzzleModel} = require './common/models/puzzle' # required by .populate()

SessionManager = require './session-manager'
QuickDraw = require './quickdraw'

class Service

	start: (http_server) ->

		facets_sandbox_logger = bunyan.createLogger
			name: 'cssqd-facets-sandbox'
			streams: [
				path: "#{__dirname}/../cssqd-facets-sandbox-log.json"
			]
		@facets_sandbox_log = (info) ->
			facets_sandbox_logger.info info

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

		@state = null

		GameSessionModel
			.find {}
			.populate 'puzzles'
			.exec (err, game_sessions) =>
				@state = QuickDraw
					.do @state, [
						QuickDraw.init game_sessions
						QuickDraw.create_sandbox @facets_sandbox_log
					]
			.then =>
				logger.info 'service-start'
				{@sandbox} = @state
				new warp.Service
					transport:         new warp.WebSocketTransport
						http_server:     http_server
						session_manager: new SessionManager @
					log: @log
			.catch console.error

module.exports = Service
