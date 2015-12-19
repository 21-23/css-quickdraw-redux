warp = require 'nexus-warp'

UserPanelViewModel = (require 'common/components/user-panel').ViewModel
TimerViewModel = (require 'common/components/timer').ViewModel
ButtonViewModel = (require 'common/components/button').ViewModel

class AppViewModel
	constructor: (sessionId) ->

		@user_data = new nx.Cell
		@game_session_id = new nx.Cell
		@round_phase = new nx.Cell
		@puzzles = new nx.Cell
		@current_puzzle_index = new nx.Cell
		@node_list = new nx.Cell
		@countdown = new nx.Cell
		@role      = new nx.Cell
		@players = new nx.Collection

		@StartButtonViewModel = new ButtonViewModel 'Start'
		@StopButtonViewModel = new ButtonViewModel 'Stop'
		@NextButtonViewModel = new ButtonViewModel 'Next'

		@current_puzzle_index['<-'] @StartButtonViewModel.click, (evt) ->
			#replace with utils method
			if @target.value? then @target.value else 0
		@current_puzzle_index['<-'] @NextButtonViewModel.click, (evt) ->
			#replace with utils method
			#TODO: UNSAFE!!! check puzzles length
			if @target.value? then @target.value + 1 else 0

		@current_puzzle = new nx.Cell
			'<-': [
					[ @current_puzzle_index, @puzzles ],
					(index, puzzles) ->
						if 0 <= index < puzzles.length then puzzles[index] else null
				]

		new warp.Client
			transport: new warp.WebSocketTransport address:"ws://#{window.location.host}"
			entities:
				user_data:            @user_data
				game_session_id:      @game_session_id
				role:                 @role

				round_phase:          @round_phase
				puzzles:              @puzzles
				current_puzzle_index: @current_puzzle_index
				node_list:            @node_list
				countdown:            @countdown
				players:              @players

		@userPanelViewModel = new UserPanelViewModel @user_data
		@timerViewModel = new TimerViewModel @countdown, TimerViewModel.formats['m:ss']

		#Keep session ID set as the last operation as it triggers the data flow
		@game_session_id.value = sessionId

module.exports = AppViewModel
