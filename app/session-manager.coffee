warp = require 'nexus-warp'

SandboxFacet = require './facets/sandbox/sandbox-facet'
GameFacet    = require './facets/game/game-facet'

class SessionManager

	constructor: (@service) ->

	create: (transport, cookies) ->
		identity = cookies.find ({name}) -> name is 'identity'

		facet =
			if identity? and identity.value is 'user'
				new GameFacet @service.game_session
			else
				new SandboxFacet @service.sandbox

		new warp.Session
			facet:     facet
			transport: transport
			entities:  facet.entities

module.exports = SessionManager
