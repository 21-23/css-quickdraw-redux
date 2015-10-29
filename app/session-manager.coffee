warp = require 'nexus-warp'

MatcherFacet = require './facets/matcher/matcher-facet'

class SessionManager

	constructor: (@service) ->

	create: (transport) ->
		facet = new MatcherFacet @service.matcher

		new warp.Session
			transport: transport
			entities:  facet.entities

module.exports = SessionManager
