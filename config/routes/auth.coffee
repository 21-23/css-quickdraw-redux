Router     = require 'koa-router'
Strategies = require 'auth/strategies'
CSSQDConfig = require 'cssqd-config'

authPath = CSSQDConfig.get 'service:auth:url'
router = new Router prefix: "/#{authPath}"

for provider, strategy of Strategies
	router.use strategy.middleware()

router.get '/logout', ->
	#log out and redirect to landing;
	#think about different redirect views
	#e.g. from /game.html?id=563 --to--> /game.html?id=563 --auto--> /quick-login.html
	do @logout
	@redirect '/'

module.exports = router
