## all resources which require authentication to access them should be placed here

Router = require 'koa-router'
router = new Router

router.get '/game', ->
	if @passport.user.role is 'game_master'
		@state.view_name = 'game-master'
		@state.title = 'Game Master'
	else
		@state.view_name = 'game'
		@state.title = 'Game'

	@state.sessionId = (@cookies.get 'gameSessionId') or @request.query.id

	yield @render 'game'

module.exports = router
