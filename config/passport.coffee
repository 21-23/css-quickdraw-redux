passport       = require 'koa-passport'
authStrategies = require 'auth/strategies'
User           = require 'models/User'


passport.serializeUser (profile, done) ->
	User.fromOAuthProfile profile
		.then (user) -> done null, user.id

passport.deserializeUser (id, done) ->
	User.findOne(id: id).exec()
		.then (user) -> done null, user


for provider, authStrategy of authStrategies
	passport.use authStrategy.passportStrategy
