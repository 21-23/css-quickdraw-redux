bodyParser  = require 'koa-bodyparser'
cssqdConfig = require 'cssqd-config'

module.exports = (app) ->
	app.use do bodyParser

	app.keys = [cssqdConfig.get 'session:secret']
	app.use session app
