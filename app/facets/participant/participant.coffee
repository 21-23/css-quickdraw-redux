{nx} = require 'nexus-node'

GameRole = require 'cssqd-shared/models/game-role'

class Participant

	constructor: (@service, user) ->
		@id = user._id

		@user_data = new nx.Cell
			value:
				id: @id
				display_name: user.displayName

		@game_session = new nx.Cell
			action: (game_session) =>
				game_session.add_participant @

		@game_session_id = new nx.Cell
			'->': [@game_session, (id) => @service.game_sessions.get id]

		@round_phase = new nx.Cell
			'<<-*': [@game_session, 'round_phase']

		@puzzles = new nx.Cell
			'<<-*': [@game_session, 'puzzles']

		@node_list = new nx.Cell
			'<<-*': [@game_session, 'node_list']

		@countdown = new nx.Cell
			'<<-*': [@game_session, ({countdown: {remaining}}) -> remaining]

		@role = new nx.Cell
			'<-': [
				@game_session,
				({game_master_id}) =>
					if game_master_id.equals @id
						GameRole.GAME_MASTER
					else
						GameRole.PLAYER
			]

		@disconnected = new nx.Cell
			action: =>
				@game_session.value?.remove_participant @

module.exports = Participant
