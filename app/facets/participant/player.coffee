{nx} = require 'nexus-node'

Round = require './round'
SelectorMatchResult = require 'cssqd-shared/models/selector-match-result'
GameSession = require '../../game-session'

class Player

	constructor: (@participant) ->
		@participant.selector = new nx.Cell
			'->*': [
				@participant.game_session,
				'selector',
				(selector) =>
					selector: selector
					player_id: do @participant.id.toString
			]

		@participant.match = new nx.Cell

		@participant.current_puzzle_index = new nx.Cell
			'<<-*': [@participant.game_session, 'current_puzzle_index']

		@participant.round_start_time = new nx.Cell
			'<<-*': [@participant.game_session, 'round_start_time']

		@participant.rounds = new nx.Collection
			transform: nx.LiveTransform ['status', 'solution']

		@participant.rounds.command['<<-*'] @participant.game_session, 'puzzles', (puzzles) ->
			items = puzzles.map (puzzle) -> new Round
			new nx.Command 'reset', {items}

		@participant.match['->'] \
			(=>
				{solution} = do @get_current_round
				solution),

			({result}) =>
				if result is SelectorMatchResult.POSITIVE
					time: do @get_solution_time
					selector: @participant.selector.value
				else
					time: GameSession.ROUND_DURATION
					selector: 'x__x'

	get_current_round: ->
		@participant.rounds.items[@participant.current_puzzle_index.value]

	get_solution_time: ->
		now = do Date.now
		elapsed = now - @participant.round_start_time.value
		GameSession.ROUND_DURATION - elapsed

	get_entities: ->
		round_phase: @participant.round_phase
		node_list:   @participant.node_list
		countdown:   @participant.countdown

		selector: @participant.selector
		match:    @participant.match
		rounds:
			link: @participant.rounds
			item_to_json: (round) -> do round.to_json

module.exports = Player
