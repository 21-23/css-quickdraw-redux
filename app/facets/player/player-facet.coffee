{nx} = require 'nexus-node'

Player = require './player'

class PlayerFacet

	constructor: (@service) ->

		player = new Player @service

		@entities =
			# selector: game.selector
			# match:    game.match
			game_session_id:      player.game_session_id
			round_phase:          player.round_phase
			puzzles:              player.puzzles
			current_puzzle_index: player.current_puzzle_index

	init: (session) ->

	destroy: (session) ->

module.exports = PlayerFacet
