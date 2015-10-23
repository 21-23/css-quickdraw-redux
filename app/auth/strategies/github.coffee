{ Strategy }      = require 'passport-github'
BaseOAuthStrategy = require 'auth/base-strategy'

class GithubStrategy extends BaseOAuthStrategy
	constructor: ->
		@name = 'github'
		@Strategy = Strategy

		super()

module.exports = new GithubStrategy
