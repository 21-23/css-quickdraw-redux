warp = require 'nexus-warp'

SandboxFacet     = require './facets/sandbox/sandbox-facet'
ParticipantFacet = require './facets/participant/participant-facet'

class SessionManager

	constructor: (@service) ->

	create: (transport, cookies) ->
		# auth = cookies.find ({name}) -> name is 'auth'
		user = {}

		facet =
			if user.is_sandbox
				new SandboxFacet @service.sandbox
			else
				new ParticipantFacet @service

		new warp.Session
			facet:     facet
			transport: transport

module.exports = SessionManager
