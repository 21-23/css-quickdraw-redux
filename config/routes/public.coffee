# all resources accessible without authentication should be placed here

authRouter  = require './auth'
cssqd_config = require 'cssqd-config'

Router = require 'koa-router'
router = new Router

#TODO: a quick hack to check if user is logged in or not
router.get '/isAuthed', ->
	@body =
		# make Gunslinger bots' lives easier
		if cssqd_config.get('service:blind_guardian') is yes
			isAuthed: yes
		else
			isAuthed: do @isAuthenticated

router.use authRouter.middleware()

module.exports = router
