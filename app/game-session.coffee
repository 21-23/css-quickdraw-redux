{nx} = require 'nexus-node'

RoundPhase          = require 'cssqd-shared/models/round-phase'
SelectorMatchResult = require 'cssqd-shared/models/selector-match-result'
GameSessionCommand  = require 'cssqd-shared/models/game-session-command'

{PuzzleModel} = require './common/models/puzzle'
Countdown     = require './common/components/countdown/countdown'
Scorekeeper   = require './scorekeeper'

class GameSession

	@COUNTDOWN_DURATION: 3 * 1000
	@ROUND_DURATION: 2 * 60 * 1000

	constructor: (data, @sandbox) ->
		{puzzles, @game_master_id} = data

		@participants = new nx.Collection
		@participants_by_id = new Map

		@scorekeeper = new Scorekeeper
			default_score: GameSession.ROUND_DURATION

		@score = new Map

		Switchboard =
			to: (id, cell) =>
				participant = @participants_by_id.get id
				participant?[cell] or Switchboard.nobody

			to_score: (id) =>
				@score.get id

			all_scores: =>
				cells = []
				@score.forEach (cell) -> cells.push cell
				cells

			all: (cell) =>
				=> @participants.items.map (participant) -> participant[cell]

			nobody: []

		@puzzles = new nx.Cell
			'->': [Switchboard.all 'puzzles']

		@raw_puzzle = new nx.Cell
		@raw_puzzle['->'] @sandbox.puzzle_data

		@node_list = new nx.Cell
			'<-': [@sandbox.node_list]

		@puzzle = new nx.Cell
			'<-': [
				@node_list
				(node_list) =>
					name: @raw_puzzle.value.name
					time_limit: GameSession.ROUND_DURATION
					index: @round_start.value.puzzle_index
					tags: node_list
					banned_characters: @raw_puzzle.value.banned
			]
			'->': [Switchboard.all 'puzzle']

		@round_phase = new nx.Cell
			value: RoundPhase.WAIT_SCREEN
			'->': [Switchboard.all 'round_phase']

		@round_start = new nx.Cell
		@round_start['->'] @raw_puzzle, ({puzzle_index}) => @puzzles.value[puzzle_index]
		@round_start['->'] @round_phase, -> RoundPhase.COUNTDOWN

		@round_start_time = new nx.Cell
			'<-': [@round_start, -> do Date.now + GameSession.COUNTDOWN_DURATION]

		@round_end = new nx.Cell
		@round_end['->'] @round_phase, -> RoundPhase.FINISHED

		@command = new nx.Cell
			'->': [
				(({action}) =>
					switch action
							when GameSessionCommand.START_ROUND then @round_start
							when GameSessionCommand.END_ROUND then @round_end),
				({data}) -> data
			]

		@round = new nx.Cell
			'<-': [
				[@puzzles, @puzzle, @node_list, @round_phase]
				(puzzles, puzzle, node_list, round_phase) ->
					{
						puzzles,
						puzzle,
						node_list,
						round_phase
					}
			]

		@round_sync = new nx.Cell
			'->': [
				nx.Identity
				=> @round.value
			]

		@participant = new nx.Cell
			'->': [
				@round_sync
				({id}) -> Switchboard.to id.toString(), 'round'
			]

		@selector = new nx.Cell
			'->': [@sandbox.selector]

		@sandbox.match['->'] ({player_id}) ->
			Switchboard.to player_id, 'match'

		@solution = new nx.Cell
			'<-': [
				@sandbox.match
				({result, selector, player_id}) =>
					if result is SelectorMatchResult.POSITIVE
						player_id: player_id
						correct:   yes
						time:      do @get_solution_time
						selector:  selector
					else
						player_id: player_id
						correct:   no
						time:      GameSession.ROUND_DURATION
						selector:  selector
			]
			'->': [
				({player_id}) =>
					[
						Switchboard.to player_id, 'solution'
						Switchboard.to @game_master_id.toString(), 'solution'
					]
			]

		@round_phase['->'] \
			((phase) ->
				if phase is RoundPhase.IN_PROGRESS
					do Switchboard.all_scores
				else
					Switchboard.nobody),
			-> GameSession.ROUND_DURATION

		@aggregate_score = new nx.Cell
			'->': [
				=> Switchboard.to @game_master_id.toString(), 'aggregate_score'
			]

		@round_phase['->'] \
			((phase) =>
				if phase is RoundPhase.FINISHED
					@aggregate_score
				else
					Switchboard.nobody),
			=>
				round_score = {}
				@score.forEach ({value}, player_id) =>
					if player_id isnt @game_master_id.toString()
						round_score[player_id] = value
				@scorekeeper.add_round round_score
				for score in do @scorekeeper.aggregate
					if @participants_by_id.has score.id
						player = @participants_by_id.get score.id
						score.name = player.user_data.value.display_name
					score


		@solution['->'] \
			(({player_id}) -> Switchboard.to_score player_id),
			({time}) -> time

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

		@countdown.remaining['->'] Switchboard.all 'countdown'

		@puzzles.value = puzzles

	get_solution_time: ->
		now = do Date.now
		now - @round_start_time.value

	add_participant: (participant) ->
		@participants.append participant
		@participants_by_id.set participant.id.toString(), participant
		@score.set participant.id.toString(), new nx.Cell

		@participant.value = participant

	remove_participant: (participant) ->
		@participants.remove participant
		@participants_by_id.delete participant.id.toString()
		@score.delete participant.id.toString()

module.exports = GameSession
