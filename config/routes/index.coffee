publicRouter = require './public.coffee'
privateRouter = require './private.coffee'

module.exports = (app) ->
	app.use do publicRouter.middleware

	app.use (next) ->
		if @isAuthenticated()
			@cookies.set 'auth', @passport.user.role, signed: true
			yield next
		else
			@redirect '/'

	app.use do privateRouter.middleware
