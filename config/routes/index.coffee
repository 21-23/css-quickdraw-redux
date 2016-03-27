publicRouter  = require './public.coffee'
privateRouter = require './private.coffee'
cssqd_config  = require 'cssqd-config'

module.exports = (app) ->
	app.use do publicRouter.middleware

	app.use (next) ->
		if @isAuthenticated()
			@cookies.set 'auth', @passport.user.role, signed: yes
			yield next

		else
			if @request.path is '/game'
				@cookies.set 'gameSessionId', @request.query.id

			if (cssqd_config.get 'service:blind_guardian') and @request.query.role is 'gunslinger'
				@cookies.set 'auth', 'player', signed: yes
				session_data = passport:
					user: 'sandbox'

				@cookies.set 'koa:sess', (new Buffer JSON.stringify session_data).toString 'base64'
				yield next

			else
				@redirect '/quick-login.html'

	app.use do privateRouter.middleware
