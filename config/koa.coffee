bodyParser  = require 'koa-bodyparser'
session     = require 'koa-session'
passport    = require 'koa-passport'
cssqdConfig = require 'cssqd-config'


module.exports = (app) ->
	app.use do bodyParser

	app.keys = [cssqdConfig.get 'session:secret']
	app.use session app
	app.use passport.initialize()
	app.use passport.session()
