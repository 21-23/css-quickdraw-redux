{nx} = require 'nexus-node'

RoundPhase    = require 'cssqd-shared/models/round-phase'

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
			participant = @participants_by_id.get player_id
			participant.match

		@round_phase = new nx.Cell
			value: RoundPhase.WAIT_SCREEN
			'<-': [@current_puzzle_index, -> RoundPhase.COUNTDOWN]

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

	add_participant: (participant) ->
		@participants.append participant
		@participants_by_id.set participant.id.toString(), participant

	remove_participant: (participant) ->
		@participants.remove participant
		@participants_by_id.delete participant.id.toString()

module.exports = GameSession
