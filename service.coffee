cssqdConfig = require 'cssqd-config'
path        = require 'path'
koa         = require 'koa'
serve       = require 'koa-static'
appConfig   = require './config'

require './config/passport'

app = do koa

console.log "mongo connection string: #{cssqdConfig.get 'mongo_connection_string'}"
console.log "port: #{cssqdConfig.get 'service:port'}"

appConfig.configureKoa    app
appConfig.configureRoutes app

app.listen cssqdConfig.get 'service:port'
