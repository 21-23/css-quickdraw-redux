publicRouter = require './public.coffee'
privateRouter = require './private.coffee'

module.exports = (app) ->
	app.use do publicRouter.middleware

	app.use (next) ->
		if @isAuthenticated()
			yield next
		else
			@redirect '/'

	app.use do privateRouter.middleware
