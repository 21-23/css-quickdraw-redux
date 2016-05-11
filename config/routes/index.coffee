publicRouter  = require './public.coffee'
privateRouter = require './private.coffee'
cssqd_config  = require 'cssqd-config'

id_aliases = cssqd_config.get 'id_aliases'

module.exports = (app) ->
	app.use do publicRouter.middleware

	app.use (next) ->
		if @isAuthenticated()
			@cookies.set 'auth', @passport.user.role, signed: yes
			yield next

		else
			if @request.path is '/game'
				unless @request.query.id
					@redirect '/'
				else
					session_id = id_aliases[@request.query.id]
					unless session_id
						@redirect '/'
					else
						@cookies.set 'gameSessionId', session_id

			if cssqd_config.get 'service:blind_guardian'
				@passport.user =
					id: @request.query.user_id

				yield next

			else
				@redirect '/quick-login.html'

	app.use do privateRouter.middleware
