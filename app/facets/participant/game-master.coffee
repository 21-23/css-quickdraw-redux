{nx} = require 'nexus-node'

class GameMaster

	constructor: (@participant) ->

		@puzzles = new nx.Cell
			'<<-*': [@participant.game_session, 'puzzles']

		@current_puzzle_index = new nx.Cell
			'->*': [@participant.game_session, 'current_puzzle_index']

	get_entities: ->
		round_phase:          @participant.round_phase
		node_list:            @participant.node_list
		countdown:            @participant.countdown
		puzzles:              @puzzles
		current_puzzle_index: @current_puzzle_index

module.exports = GameMaster
