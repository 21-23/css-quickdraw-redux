GameMaster = require './game-master'

class GameMasterFacet

	constructor: (service) ->

		game_master = new GameMaster service

		@entities =
			game_session_id: game_master.game_session_id
			round_phase:     game_master.round_phase

	init: (session) ->

	destroy: (session) ->

module.exports = GameMasterFacet
