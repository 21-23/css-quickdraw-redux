# all resources accessible without authentication should be placed here

authRouter = require './auth'

Router = require 'koa-router'
router = new Router

#TODO: a quick hack to check if user is logged in or not
router.get '/isAuthed', ->
	@body = isAuthed: @isAuthenticated()

router.use authRouter.middleware()

module.exports = router
