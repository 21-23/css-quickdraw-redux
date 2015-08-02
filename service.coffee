cssqdConfig = require 'cssqd-config'
path        = require 'path'

cssqdConfig
	.env
		separator: '__'

cssqdConfig
	.useDir path.join __dirname, 'config'

console.log "mongo connection string: #{cssqdConfig.get 'mongo_connection_string'}"
console.log "port: #{cssqdConfig.get 'service:port'}"
