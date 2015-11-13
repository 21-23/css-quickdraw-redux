{nx} = require 'nexus-node'

Player = require './player'

class PlayerFacet

	constructor: (@service) ->

		@player = new Player @service

		@entities =
			game_session_id: @player.game_session_id
			round_phase:     @player.round_phase
			node_list:       @player.node_list
			countdown:       @player.countdown

			selector: @player.selector
			match:    @player.match

	init: (session) ->

	destroy: (session) ->
		@player.disconnected.value = yes

module.exports = PlayerFacet
