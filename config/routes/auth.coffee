Router     = require 'koa-router'
Strategies = require 'auth/strategies'
CSSQDConfig = require 'cssqd-config'

authPath = CSSQDConfig.get 'service:auth:url'
router = new Router prefix: "/#{authPath}"

for provider, strategy of Strategies
	router.use strategy.middleware()

module.exports = router
