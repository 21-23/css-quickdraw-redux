{nx} = require 'nexus-node'

RoundPhase    = require 'cssqd-shared/models/round-phase'
SelectorMatchResult = require 'cssqd-shared/models/selector-match-result'

{PuzzleModel} = require './common/models/puzzle'
Countdown     = require './common/components/countdown/countdown'

class GameSession

	@COUNTDOWN_DURATION: 3 * 1000
	@ROUND_DURATION: 2 * 60 * 1000

	constructor: (data, @sandbox) ->
		{puzzles, @game_master_id} = data

		@participants = new nx.Collection
		@participants_by_id = new Map

		@puzzles = new nx.Cell value:puzzles

		@current_puzzle_index = new nx.Cell
			'->': [@sandbox.puzzle_data, (index) => @puzzles.value[index]]

		@node_list = new nx.Cell
			'<-': [@sandbox.node_list]

		@selector = new nx.Cell
			'->': [@sandbox.selector]

		@sandbox.match['->'] ({player_id}) =>
			player = @participants_by_id.get player_id
			player.match

		@solution = new nx.Cell
			'<-': [
				@sandbox.match
				({result, selector, player_id}) =>
					if result is SelectorMatchResult.POSITIVE
						player_id: player_id
						correct:    yes
						time:      do @get_solution_time
						selector:  selector
					else
						player_id: player_id
						correct:    no
						time:      GameSession.ROUND_DURATION
						selector:  'x__x'
			]
			'->': [
				({player_id}) =>
					player = @participants_by_id.get player_id
					player.solution
			]

		@round_phase = new nx.Cell
			value: RoundPhase.WAIT_SCREEN
			'<-': [@current_puzzle_index, -> RoundPhase.COUNTDOWN]

		@round_start_time = new nx.Cell
			'<-': [@current_puzzle_index, -> do Date.now]

		@countdown = new Countdown
		@countdown.time['<-'] @round_phase, (phase) ->
			switch phase
				when RoundPhase.COUNTDOWN then GameSession.COUNTDOWN_DURATION
				when RoundPhase.IN_PROGRESS then GameSession.ROUND_DURATION
				else 0

		@countdown.active['<-'] @round_phase, (phase) ->
			phase in [RoundPhase.COUNTDOWN, RoundPhase.IN_PROGRESS]

		@countdown.timeout['->'] @round_phase, =>
			switch @round_phase.value
				when RoundPhase.COUNTDOWN then RoundPhase.IN_PROGRESS
				when RoundPhase.IN_PROGRESS then RoundPhase.FINISHED

	get_solution_time: ->
		now = do Date.now
		elapsed = now - @round_start_time.value
		GameSession.ROUND_DURATION - elapsed

	add_participant: (participant) ->
		@participants.append participant
		@participants_by_id.set participant.id.toString(), participant

	remove_participant: (participant) ->
		@participants.remove participant
		@participants_by_id.delete participant.id.toString()

module.exports = GameSession
