Router     = require 'koa-router'
Strategies = require 'auth/strategies'

router = new Router prefix: '/auth'

for strategy of Strategies
	router.use strategy.middleware()

module.exports = router
