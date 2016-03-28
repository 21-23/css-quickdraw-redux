## all resources which require authentication to access them should be placed here

Router = require 'koa-router'
router = new Router

{GameSessionModel} = require 'common/models/game-session'
User = require 'models/User'

router.get '/game', ->
	[[gameSession], {_id}] = yield [
		GameSessionModel.find {}
		User.findOne id: @passport.user.id
	]

	if _id.toString() is gameSession.game_master_id.toString()
		@state.view_name = 'game-master'
		@state.title = 'Game Master'
	else
		@state.view_name = 'game'
		@state.title = 'Game'

	@state.sessionId = (@cookies.get 'gameSessionId') or @request.query.id

	yield @render 'game'

module.exports = router
