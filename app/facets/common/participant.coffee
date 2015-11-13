{nx} = require 'nexus-node'

class Participant

	@id: 0

	constructor: (@service) ->
		@id = Participant.id++

		@game_session = new nx.Cell
			action: (game_session) =>
				game_session.add_participant @

		@round_phase = new nx.Cell
			'<<-*': [@game_session, 'round_phase']

		@node_list = new nx.Cell
			'<<-*': [@game_session, 'node_list']

		@countdown = new nx.Cell
			'<<-*': [@game_session, ({countdown: {remaining}}) -> remaining]

		@game_session_id = new nx.Cell
			'->': [@game_session, (id) => @service.game_sessions.get id]

		@disconnected = new nx.Cell
			action: =>
				@game_session.value?.remove_participant @

module.exports = Participant
