{ Strategy }      = require 'passport-facebook'
BaseOAuthStrategy = require 'auth/base-strategy'

class FBStrategy extends BaseOAuthStrategy
	constructor: ->
		@name = 'facebook'
		@Strategy = Strategy

		super()

module.exports = new FBStrategy
