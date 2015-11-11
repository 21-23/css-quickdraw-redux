warp = require 'nexus-warp'

SandboxFacet     = require './facets/sandbox/sandbox-facet'
PlayerFacet      = require './facets/player/player-facet'
GameMasterFacet  = require './facets/game-master/game-master-facet'

class SessionManager

	constructor: (@service) ->

	create: (transport, cookies) ->
		auth = cookies.find ({name}) -> name is 'auth'

		facet =
			if auth?
				switch auth.value
					when 'player' then new PlayerFacet @service
					when 'game_master' then new GameMasterFacet @service
			else
				new SandboxFacet @service.sandbox

		new warp.Session
			facet:     facet
			transport: transport
			entities:  facet.entities

module.exports = SessionManager
