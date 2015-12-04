warp = require 'nexus-warp'

SandboxFacet    = require './facets/sandbox/sandbox-facet'
PlayerFacet     = require './facets/player/player-facet'
GameMasterFacet = require './facets/game-master/game-master-facet'
GameRole        = require '../shared/models/game-role'

class SessionManager

	constructor: (@service) ->

	create: (transport, cookies) ->
		# auth = cookies.find ({name}) -> name is 'auth'
		user = {}

		facet =
			if user.is_sandbox
				new SandboxFacet @service.sandbox
			else
				facet: ParticipantFacet
				capture: ['role']
				morph: (role) ->
					switch role
						when GameRole.GAME_MASTER
							new GameMasterFacet @service
						when GameRole.PLAYER
							new PlayerFacet @service

		new warp.Session
			facet:     facet
			transport: transport

module.exports = SessionManager
