## all resources which require authentication to access them should be placed here

Router = require 'koa-router'
router = new Router

router.get '/', (next) ->
	@body = JSON.stringify @passport.user, null, 2

module.exports = router
