warp = require 'nexus-warp'
{nx} = require 'nexus'

MatchRendererViewModel = (require 'common/components/match-renderer').ViewModel

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

		@game_session_id.value = sessionId

		@matchRendererViewModel = new MatchRendererViewModel
			node_list: @node_list
			match: @match

module.exports = AppViewModel
