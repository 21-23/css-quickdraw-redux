{ Strategy }      = require 'passport-twitter'
BaseOAuthStrategy = require 'auth/base-strategy'

class TwitterStrategy extends BaseOAuthStrategy
	constructor: ->
		@name = 'twitter'
		@Strategy = Strategy

		super()

	getReqOptions: ->
		consumerKey: @options.clientID
		consumerSecret: @options.clientSecret
		callbackURL: @callbackURL

module.exports = new TwitterStrategy
