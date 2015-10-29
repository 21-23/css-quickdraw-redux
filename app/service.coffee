warp = require 'nexus-warp'

Matcher = require './facets/matcher/matcher'
SessionManager = require './session-manager'

class Service

	start: (http_server) ->

		@matcher = new Matcher

		new warp.Service
			transport: new warp.WebSocketTransport
				http_server: http_server
				session_manager: new SessionManager @
			entities:
				player_selector: @matcher.selector
				player_match: @matcher.match

module.exports = Service
