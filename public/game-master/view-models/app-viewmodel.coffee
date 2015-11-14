warp = require 'nexus-warp'

class AppViewModel
	constructor: ->

		@game_session_id = new nx.Cell
		@round_phase = new nx.Cell
		@puzzles = new nx.Cell
		@current_puzzle_index = new nx.Cell
		@node_list = new nx.Cell
		@countdown = new nx.Cell

		new warp.Client
			transport: new warp.WebSocketTransport address:"ws://#{window.location.host}"
			entities:
				game_session_id:      @game_session_id
				round_phase:          @round_phase
				puzzles:              @puzzles
				current_puzzle_index: @current_puzzle_index
				node_list:            @node_list
				countdown:            @countdown

		@game_session_id.value = '563e67b5e3177999a8406ac4'

module.exports = AppViewModel
