passport    = require 'koa-passport'
Router      = require 'koa-router'
CSSQDConfig = require 'cssqd-config'

{ APP_BASE_URL } = require 'cssqd-config/constants'

class BaseOAuthStrategy
	constructor: (clientID, clientSecret) ->
		@options =
			clientID: CSSQDConfig.get "service:auth:keys:#{@name}:public"
			clientSecret: CSSQDConfig.get "service:auth:keys:#{@name}:private"

		authPath = CSSQDConfig.get 'service:auth:url'

		@authPath = authPath
		@callbackURL = "#{APP_BASE_URL}/#{authPath}/#{@name}/callback"
		@passportStrategy = new @Strategy @getReqOptions(), @verify

	verify: (token, tokenSecret, profile, done) ->
		done null, profile

	middleware: ->
		router = new Router prefix: "/#{@name}"
		router.get '/', passport.authenticate @name
		router.get '/callback', passport.authenticate @name,
			successRedirect: CSSQDConfig.get 'service:auth:successRedirect'
			failureRedirect: CSSQDConfig.get 'service:auth:failureRedirect'

		router.middleware()

	getReqOptions: ->
		clientID: @options.clientID
		clientSecret: @options.clientSecret
		callbackURL: @callbackURL


module.exports = BaseOAuthStrategy
