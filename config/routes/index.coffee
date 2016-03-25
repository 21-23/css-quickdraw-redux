publicRouter  = require './public.coffee'
privateRouter = require './private.coffee'
cssqd_config  = require 'cssqd-config'

module.exports = (app) ->
	app.use do publicRouter.middleware

	app.use (next) ->
		if @isAuthenticated()
			@cookies.set 'auth', @passport.user.role, signed: yes
			yield next

		else if cssqd_config.get 'service:blind_guardian'
			@cookies.set 'auth', 'player', signed: yes
			yield next

		else
			if @request.path is '/game'
				@cookies.set 'gameSessionId', @request.query.id

			@redirect '/quick-login.html'

	app.use do privateRouter.middleware
