passport       = require 'koa-passport'
authStrategies = require 'auth/strategies'

## temp
users = {}

passport.serializeUser (user, done) ->
	users[user.id] = user
	done null, user.id

passport.deserializeUser (id, done) ->
	done null, users[id]

for provider, authStrategy of authStrategies
	passport.use authStrategy.passportStrategy
