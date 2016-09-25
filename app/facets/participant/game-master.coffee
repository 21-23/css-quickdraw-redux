{nx} = require 'nexus-node'

GameRole = require 'cssqd-shared/models/game-role'

class GameMaster

	constructor: (@participant) ->
		participants = do @participant.game_session.value.participants.items.slice
		@participant.participants = new nx.Collection	items:participants

		@participant.command = new nx.Cell
			'->*': [@participant.game_session, 'command']

		@participant.participants.command['<-*'] \
			@participant.game_session,
			({participants: {command}}) -> command

		@participant.players = @participant.participants.filter
			values: ['role']
			filter: (role) -> role isnt GameRole.GAME_MASTER
			binding: '->>'

		@participant.aggregate_score = new nx.Cell

	get_entities: ->
		# round_phase: @participant.round_phase
		# puzzle:      @participant.puzzle
		# puzzles:     @participant.puzzles # GM only

		# countdown:   @participant.countdown
		# solution:    @participant.solution

		command:     @participant.command # GM only

		# players:
		# 	link: @participant.players
		# 	item_to_json: ({user_data: {value}}) -> value

		# aggregate_score: @participant.aggregate_score #GM only

module.exports = GameMaster
