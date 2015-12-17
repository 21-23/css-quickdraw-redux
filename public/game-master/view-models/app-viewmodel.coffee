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

		@startButtonClick = new nx.Cell
		@stopButtonClick = new nx.Cell
		@nextButtonClick = new nx.Cell

		@current_puzzle_index['<-'] @startButtonClick, (evt) ->
			#replace with utils method
			if typeof @target.value is 'undefined' then 0 else @target.value
		@current_puzzle_index['<-'] @nextButtonClick, (evt) ->
			#replace with utils method
			#TODO: UNSAFE!!! check puzzles length
			if typeof @target.value is 'undefined' then 0 else @target.value + 1

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

		@StartButtonViewModel = new ButtonViewModel text: 'Start', click: @startButtonClick
		@StopButtonViewModel = new ButtonViewModel text: 'Stop', click: @stopButtonClick
		@NextButtonViewModel = new ButtonViewModel text: 'Next', click: @nextButtonClick

		#Keep session ID set as the last operation as it triggers the data flow
		@game_session_id.value = sessionId

module.exports = AppViewModel
