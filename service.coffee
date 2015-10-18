cssqdConfig = require 'cssqd-config'
path        = require 'path'
koa         = require 'koa'
serve       = require 'koa-static'

app = do koa

cssqdConfig
	.env
		separator: '__'

cssqdConfig
	.useDir path.join __dirname, 'config'

console.log "mongo connection string: #{cssqdConfig.get 'mongo_connection_string'}"
console.log "port: #{cssqdConfig.get 'service:port'}"

app.use serve path.join __dirname, cssqdConfig.get 'service:static'

app.listen cssqdConfig.get 'service:port'
