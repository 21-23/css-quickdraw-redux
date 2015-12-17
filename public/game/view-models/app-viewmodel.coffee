warp = require 'nexus-warp'
{nx} = require 'nexus'

Round = require '../models/round'
MatchRendererViewModel = (require 'common/components/match-renderer').ViewModel
UserPanelViewModel = (require 'common/components/user-panel').ViewModel
TimerViewModel = (require 'common/components/timer').ViewModel

class AppViewModel
	constructor: (sessionId) ->

		@user_data = new nx.Cell
		@game_session_id = new nx.Cell
		@round_phase = new nx.Cell
		@node_list = new nx.Cell
		@countdown = new nx.Cell
		@role = new nx.Cell

		@selector = new nx.Cell
		@match = new nx.Cell

		@rounds = new nx.Collection

		@view = new nx.Cell
			'<-': [
					@round_phase,
					# convert phase to view alias; for now - 1-to-1 conversion
					nx.Identity
				]

		new warp.Client
			transport: new warp.WebSocketTransport address:"ws://#{window.location.host}"
			entities:
				user_data:       @user_data
				game_session_id: @game_session_id
				round_phase:     @round_phase
				node_list:       @node_list
				countdown:       @countdown
				role:            @role

				selector: @selector
				match:    @match

				rounds:
					link: @rounds
					item_from_json: ({status, solution}) -> new Round status, solution

		@matchRendererViewModel = new MatchRendererViewModel
			node_list: @node_list
			match: @match

		@userPanelViewModel = new UserPanelViewModel @user_data
		@roundTimerViewModel = new TimerViewModel @countdown, TimerViewModel.formats['m:ss']

		#Keep session ID set as the last operation as it triggers the data flow
		@game_session_id.value = sessionId

module.exports = AppViewModel
