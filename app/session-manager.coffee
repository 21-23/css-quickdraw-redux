warp = require 'nexus-warp'

User = require './models/User'
SandboxFacet     = require './facets/sandbox/sandbox-facet'
ParticipantFacet = require './facets/participant/participant-facet'

class SessionManager

	constructor: (@service) ->

	create: (transport, cookies, done) ->
		user = {}

		session_cookie = cookies.find ({name}) ->
			name is 'koa:sess'

		session_data = JSON.parse (new Buffer session_cookie.value, 'base64').toString 'utf8'
		user_id = session_data.passport.user

		if user_id is 'sandbox'
			facet = new SandboxFacet @service.sandbox
			session = new warp.Session
				facet:     facet
				transport: transport
			done session
		else
			User.findOne id:user_id, (err, user) =>
				facet = new ParticipantFacet @service, user
				session = new warp.Session
					facet:     facet
					transport: transport
				done session

module.exports = SessionManager