warp = require 'nexus-warp'

SandboxFacet = require './facets/sandbox/sandbox-facet'

class SessionManager

	constructor: (@service) ->

	create: (transport) ->
		facet = new SandboxFacet @service.sandbox

		new warp.Session
			facet:     facet
			transport: transport
			entities:  facet.entities

module.exports = SessionManager
