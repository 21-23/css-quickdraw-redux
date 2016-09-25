{nx} = require 'nexus-node'

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

		@participant.session_info = new nx.Cell
			'<<-': [
				@participant.puzzles
				(puzzles) ->
					puzzle_names: puzzles.map ({name}) -> name
			]

	get_entities: ->
		# session_info: @participant.session_info
		# round_phase:  @participant.round_phase
		# puzzle:       @participant.puzzle

		# countdown: @participant.countdown

		selector: @participant.selector # Player only
		# match:    @participant.match    # Player only

module.exports = Player
