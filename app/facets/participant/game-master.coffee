{nx} = require 'nexus-node'

GameRole = require 'cssqd-shared/models/game-role'

class GameMaster

	constructor: (@participant) ->
		@participant.current_puzzle_index = new nx.Cell
			'->*': [@participant.game_session, 'current_puzzle_index']

		participants = do @participant.game_session.value.participants.items.slice
		@participant.participants = new nx.Collection	items:participants

		@participant.participants.command['<-*'] \
			@participant.game_session,
			({participants: {command}}) -> command

		@participant.players = @participant.participants.filter
			values: ['role']
			filter: (role) -> role isnt GameRole.GAME_MASTER
			binding: '->>'

		@participant.solution = new nx.Cell
			'<-*': [@participant.game_session, 'solution']

	get_entities: ->
		round_phase:          @participant.round_phase
		node_list:            @participant.node_list
		countdown:            @participant.countdown
		puzzles:              @participant.puzzles
		current_puzzle_index: @participant.current_puzzle_index
		solution:             @participant.solution
		players:
			link: @participant.players
			item_to_json: ({user_data: {value}}) -> value

module.exports = GameMaster
