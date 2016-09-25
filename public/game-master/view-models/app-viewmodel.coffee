warp = require 'nexus-warp'

dateTimeFormats = (require 'common/utils/date-time-utils').formats
RoundPhase = require 'cssqd-shared/models/round-phase'

Player = require '../models/player'
GameSessionCommand = require 'cssqd-shared/models/game-session-command'
{ COUNTDOWN_TIMER_STEP } = require 'cssqd-shared/constants'
UserPanelViewModel = (require 'common/components/user-panel').ViewModel
TimespanViewModel = (require 'common/components/timespan').ViewModel
ButtonViewModel = (require 'common/components/button').ViewModel
ToggleButtonViewModel = (require 'common/components/toggle-button').ViewModel
GameControlButtonViewModel = (require 'common/components/game-control-button').ViewModel
{ PlayersListViewModel, PlayersScoresListViewModel } = require 'common/components/players-list'
MatchRenderer = require 'common/components/match-renderer'
OccurrenceIndicator = require 'common/components/occurrence-indicator'
PuzzlesProgressViewModel = (require 'common/components/puzzles-progress').ViewModel
CountdownCircleViewModel = (require 'common/components/countdown-circle').ViewModel

class AppViewModel
	constructor: (session_id) ->

		@user_data = new nx.Cell
		@game_session_id = new nx.Cell
		@round_phase = new nx.Cell
		@puzzles = new nx.Cell value: []
		@puzzle = new nx.Cell
		@command = new nx.Cell
		@countdown = new nx.Cell
		@role      = new nx.Cell
		@players = new nx.Collection
			transform: nx.LiveTransform ['solution']
		@aggregate_score = new nx.Cell
		@currentRoundTimeLimit = new nx.Cell

		@current_puzzle_index = new nx.Cell
			value: -1

		@StartButtonViewModel = new ButtonViewModel 'Start'
		@StopButtonViewModel = new ButtonViewModel 'Stop'
		@NextButtonViewModel = new ButtonViewModel 'Next'

		@showScoresTogglerViewModel = new ToggleButtonViewModel '', no

		@gameControlButtonViewModel = new GameControlButtonViewModel @round_phase


		@gameControlButtonViewModel.click['->'] \
			(=>
				if @round_phase.value is RoundPhase.IN_PROGRESS or @current_puzzle_index.value < @puzzles.value.length - 1
					@command
				else
					[]),
			=>
				if @round_phase.value is RoundPhase.IN_PROGRESS
					new GameSessionCommand GameSessionCommand.END_ROUND
				else if -1 <= @current_puzzle_index.value < @puzzles.value.length - 1
					@current_puzzle_index.value++
					new GameSessionCommand GameSessionCommand.START_ROUND, puzzle_index: @current_puzzle_index.value


		@command['<-'] @StartButtonViewModel.click, =>
			new GameSessionCommand \
				GameSessionCommand.START_ROUND,
				puzzle_index: @current_puzzle_index.value

		@command['<-'] @StopButtonViewModel.click, ->
			new GameSessionCommand \
				GameSessionCommand.END_ROUND

		@command['<-'] @NextButtonViewModel.click, =>
			@current_puzzle_index.value++
			nextIndex = @current_puzzle_index.value

			if nextIndex < @puzzles.value.length
				new GameSessionCommand \
					GameSessionCommand.START_ROUND,
					puzzle_index: nextIndex




		@current_puzzle = new nx.Cell
			'<-': [
					[ @current_puzzle_index, @puzzles ],
					(index, puzzles) ->
						if 0 <= index < puzzles.length then puzzles[index] else null
				]

		@solution = new nx.Cell
			'->': [
				({player_id}) =>
					# obligatory apologetic comment
					{solution} = @players.items.find (player) -> player.id is player_id
					solution
			]

		@current_puzzle_visible_soultion = new nx.Cell
			'<-': [
					[ @current_puzzle, @round_phase ],
					(puzzle, phase) ->
						puzzle?.selector if phase is RoundPhase.FINISHED
				]

		@state = new nx.Cell
			action: console.log

		@warp_client = new warp.Client
			transport: new warp.WebSocketTransport address:"ws://#{window.location.host}"
			entities:
				state:   @state
				command: @command

				# user_data:       @user_data
				# game_session_id: @game_session_id
				# role:            @role
				#
				# round_phase:     @round_phase
				# puzzles:         @puzzles
				# puzzle:          @puzzle
				#
				# command:         @command
				#
				# countdown:       @countdown
				# solution:        @solution
				# players:
				# 	link: @players
				# 	item_from_json: (json) -> new Player json
				#
				# aggregate_score: @aggregate_score

		@userPanelViewModel = new UserPanelViewModel @user_data

		@currentRoundTimeLimit['<-'] [ @puzzle, @round_phase ],
			(puzzle, phase) ->
				if phase is RoundPhase.IN_PROGRESS then puzzle.time_limit else puzzle?.countdown_limit or 0

		@roundTimerViewModel = new CountdownCircleViewModel @countdown,
			@currentRoundTimeLimit
			COUNTDOWN_TIMER_STEP
			dateTimeFormats['m:ss']
			{ radius: 60, strokeWidth: 5 }

		@playersListViewModel = new PlayersListViewModel @players
		@puzzlesProgressViewModel = new PuzzlesProgressViewModel @puzzles, @current_puzzle_index
		@playersScoresListViewModel = new PlayersScoresListViewModel @aggregate_score

		@puzzlesProgressViewModel.select['->'] @current_puzzle_index

		@round_phase['->'] \
			((phase) =>
				if phase is RoundPhase.COUNTDOWN
					@playersListViewModel.players.items.map (player) -> player.solution
				else
					[]),
			-> {}

		@matchRenderer = new MatchRenderer.ViewModel
		@matchRenderer.tag_list['<-'] @puzzle,	({tags}) -> tags
			#TODO: probably pass here the correct match to highlight the correct solution

		@occurrenceIndicator = new OccurrenceIndicator.ViewModel
		@occurrenceIndicator.patterns['<-'] \
			@puzzle,
			({banned_characters}) -> banned_characters

		#Keep session ID set as the last operation as it triggers the data flow
		@command.value =
			domain:          'game_session'
			name:            'add_participant'
			game_session_id: session_id
			args:            []
		# @game_session_id.value = sessionId

module.exports = AppViewModel
