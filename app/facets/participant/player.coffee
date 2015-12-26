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

		@participant.rounds = new nx.Collection
			transform: nx.LiveTransform ['status', 'solution']

		@participant.rounds.command['<<-*'] @participant.game_session, 'puzzles', (puzzles) ->
			items = puzzles.map (puzzle) -> new Round
			new nx.Command 'reset', {items}

		@participant.solution['->'] \
			=>
				{solution} = do @get_current_round
				solution

		@participant.recovery['->'] \
			@participant.rounds.command
			({rounds}) ->	new nx.Command 'reset', items:rounds

		@participant.disconnected['->'] @participant.storage, =>
			rounds: @participant.rounds.items


	get_current_round: ->
		@participant.rounds.items[@participant.puzzle.value.index]

	get_entities: ->
		round_phase: @participant.round_phase
		puzzle:      @participant.puzzle

		countdown:   @participant.countdown

		selector: @participant.selector # Player only
		match:    @participant.match    # Player only
		rounds:
			link: @participant.rounds
			item_to_json: (round) -> do round.to_json

module.exports = Player
