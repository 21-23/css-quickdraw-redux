{nx} = require 'nexus-node'

Participant = require './participant'
Player      = require './player'
GameMaster  = require './game-master'
GameRole    = require 'cssqd-shared/models/game-role'

class ParticipantFacet

	constructor: (@service, user) ->
		@active = yes

		@participant = new Participant @service, user

		@entities =
			command: @participant.command
			state:   @participant.state

			# user_data:       @participant.user_data
			# game_session_id: @participant.game_session_id
			# role:            @participant.role

		# @dynamic_entities = new nx.Cell
		# 	'<-': [
		# 		@participant.role
		# 		(role) =>
		# 			switch role
		# 				when GameRole.GAME_MASTER
		# 					@game_master = new GameMaster @participant
		# 					do @game_master.get_entities
		#
		# 				when GameRole.PLAYER
		# 					@player = new Player @participant
		# 					do @player.get_entities
		# 	]

	destroy: (session) ->
		# if @active
		# 	@participant.disconnected.value = yes

	get_model: -> @participant

module.exports = ParticipantFacet
