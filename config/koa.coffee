bodyParser  = require 'koa-bodyparser'
cssqdConfig = require 'cssqd-config'
passport    = require 'koa-passport'

module.exports = (app) ->
	app.use do bodyParser

	app.keys = [cssqdConfig.get 'session:secret']
	app.use session app
	app.use passport.initialize()
	app.use passport.session()
