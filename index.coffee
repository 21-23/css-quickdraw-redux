cssqdConfig = require 'cssqd-config'
path        = require 'path'
koa         = require 'koa'
serve       = require 'koa-static'
mongoose    = require 'mongoose'

appConfig   = require './config'

require './config/passport'

Service = require './app/service'

app = do koa

mongo_connection_string = cssqdConfig.get 'mongo_connection_string'

console.log "mongo connection string: #{mongo_connection_string}"
console.log "port: #{cssqdConfig.get 'service:port'}"

{connection} = mongoose.connect mongo_connection_string
connection.on 'error', console.error.bind console, 'mongoose connection error:'
connection.once 'open', ->
	app.use serve path.join __dirname, cssqdConfig.get 'service:static'

	appConfig.configureKoa    app
	appConfig.configureRoutes app

	http_server = app.listen cssqdConfig.get 'service:port'
	(new Service).start http_server
