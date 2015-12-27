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
				game_session?.add_participant @

		@game_session_id = new nx.Cell
			'->': [
				((id) =>
					if @service.game_sessions.has id
						@game_session
					else
						[]
				)
				((id) => @service.game_sessions.get id)
			]

		@role = new nx.Cell
			'<-': [
				@game_session,
				({game_master_id}) =>
					if game_master_id.equals @id
						GameRole.GAME_MASTER
					else
						GameRole.PLAYER
			]

		@round = new nx.Cell

		@round_phase = new nx.Cell
			'<-': [@round, ({round_phase}) -> round_phase]

		@puzzles = new nx.Cell
			'<-': [@round, ({puzzles}) -> puzzles]

		@puzzle = new nx.Cell
			'<-': [@round, ({puzzle}) -> puzzle]

		@countdown = new nx.Cell
		@solution = new nx.Cell

		@storage = new nx.Cell
		@recovery = new nx.Cell

		@disconnected = new nx.Cell
			action: =>
				@game_session.value?.remove_participant @

module.exports = Participant
