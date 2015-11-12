GameMaster = require './game-master'

class GameMasterFacet

	constructor: (service) ->

		game_master = new GameMaster service

		@entities =
			game_session_id:      game_master.game_session_id
			round_phase:          game_master.round_phase
			puzzles:              game_master.puzzles
			current_puzzle_index: game_master.current_puzzle_index
			node_list:            game_master.node_list
			countdown:            game_master.countdown

	init: (session) ->

	destroy: (session) ->

module.exports = GameMasterFacet
