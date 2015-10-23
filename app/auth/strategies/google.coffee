{ Strategy }      = require 'passport-google-auth'
BaseOAuthStrategy = require 'auth/base-strategy'

class GoogleStrategy extends BaseOAuthStrategy
	constructor: ->
		@name = 'google'
		@Strategy = Strategy
		
		super()

	getReqOptions: ->
		clientId: @options.clientID
		clientSecret: @options.clientSecret
		callbackURL: @callbackURL

module.exports = new GoogleStrategy
