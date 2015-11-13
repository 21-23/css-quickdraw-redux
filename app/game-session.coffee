{nx} = require 'nexus-node'

{PuzzleModel} = require './common/models/puzzle'
RoundPhase    = require './common/models/round-phase'
Countdown     = require './common/components/countdown/countdown'

class GameSession

	constructor: ({puzzles}, @sandbox) ->
		@puzzles = new nx.Cell value:puzzles

		@current_puzzle_index = new nx.Cell
			'->': [@sandbox.puzzle_data, (index) => @puzzles.value[index]]

		@node_list = new nx.Cell
			'<-': [@sandbox.node_list]

		@selector = new nx.Cell
			'->': [@sandbox.selector]

		@match = new nx.Cell
			'<-': [@sandbox.match]

		@round_phase = new nx.Cell
			value: RoundPhase.WAIT_SCREEN
			'<-': [@current_puzzle_index, -> RoundPhase.COUNTDOWN]

		@countdown = new Countdown
		@countdown.time['<-'] @round_phase, (phase) ->
			switch phase
				when RoundPhase.COUNTDOWN then 5 * 1000
				when RoundPhase.IN_PROGRESS then 10 * 1000
				else 0

		@countdown.active['<-'] @round_phase, (phase) ->
			phase in [RoundPhase.COUNTDOWN, RoundPhase.IN_PROGRESS]

		@countdown.timeout['->'] @round_phase, =>
			switch @round_phase.value
				when RoundPhase.COUNTDOWN then RoundPhase.IN_PROGRESS
				when RoundPhase.IN_PROGRESS then RoundPhase.FINISHED

module.exports = GameSession
