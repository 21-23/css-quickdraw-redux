warp = require 'nexus-warp'

class AppViewModel
	constructor: ->

		@selector = new nx.Cell
		@match = new nx.Cell
		@game_session_id = new nx.Cell
		@round_phase = new nx.Cell
		@puzzles = new nx.Cell
			action: (puzzles) -> console.log puzzles

		new warp.Client
			transport: new warp.WebSocketTransport address:"ws://#{window.location.host}"
			entities:
				selector:        @selector
				match:           @match
				game_session_id: @game_session_id
				round_phase:     @round_phase
				puzzles:         @puzzles

		@game_session_id.value = '5644fb28efb1c61812c02009'

module.exports = AppViewModel
