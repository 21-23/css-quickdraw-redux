path  = require 'path'
serve = require 'koa-static'

publicRouter = require './public.coffee'
privateRouter = require './private.coffee'

module.exports = (app) ->
	app.use serve path.join __dirname, '..', '..', '/static/public'
	app.use do publicRouter.middleware

	app.use (next) ->
		if @isAuthenticated()
			yield next
		else
			@redirect '/login.html'

	app.use serve path.join __dirname, '..', '..', '/static/private'
	app.use do privateRouter.middleware
