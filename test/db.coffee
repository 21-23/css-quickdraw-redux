mongoose    = require 'mongoose'
CSSQDConfig = require 'app/cssqd-config'

mongohost = CSSQDConfig.get 'mongo:host'
mongodb   = CSSQDConfig.get 'mongo:db'

mongoose.Promise = global.Promise

connectionString = "#{mongohost}/#{mongodb}"

mongoose.connect connectionString
connection = mongoose.connection

before (done) ->
	connection.on 'open', ->
		connection.db.dropDatabase done

after (done) ->
	connection.close done
