{nx} = require 'nexus-node'

QuickDraw = require '../../quickdraw'
GameSession = require '../../game-session'

Domain =
	SERVICE:      'service'
	GAME_SESSION: 'game_session'

GameSessionPrism = (game_session_id) ->
	zoom = ({game_sessions_by_id}) ->
		game_sessions_by_id.get game_session_id
	unzoom = (state) -> state
	QuickDraw.Prism zoom, unzoom

class Participant

	@actions_by_domain:
		"#{Domain.SERVICE}":      QuickDraw
		"#{Domain.GAME_SESSION}": GameSession

	constructor: (@service, @user_data) ->

		@state = new nx.Cell
			'<-': [@service.state_json]

		@command = new nx.Cell
			action: ({domain, name, game_session_id, args}) =>

				actions = Participant.actions_by_domain[domain]
				action = actions[name]

				if name of @args_transform
					args = @args_transform[name] args

				prism =
					switch domain

						when Domain.SERVICE
							QuickDraw.do

						when Domain.GAME_SESSION
							GameSessionPrism game_session_id

				@service.state = prism @service.state, [action args...]

				if name is 'start_round'
					QuickDraw.Interval @service.state,
						prism: GameSessionPrism game_session_id
						tick: 1000
						duration: 3000
						tick_actions: [do GameSession.start_countdown_tick]
						end_actions: [do GameSession.start_countdown_end]

					QuickDraw.Interval @service.state,
						prism: GameSessionPrism game_session_id
						tick: 1000
						duration: 120000
						tick_actions: [do GameSession.round_countdown_tick]
						end_actions: [do GameSession.round_countdown_end]

		@args_transform =
			add_participant: => [@user_data]

		# @id = user._id
		#
		# @user_data = new nx.Cell
		# 	value:
		# 		id: @id
		# 		display_name: user.displayName
		#
		#
		# @game_session = new nx.Cell
		# 	action: (game_session) =>
		# 		game_session?.add_participant @
		#
		# @game_session_id = new nx.Cell
		# 	'->': [
		# 		((id) =>
		# 			if @service.game_sessions.has id
		# 				@game_session
		# 			else
		# 				[]
		# 		)
		# 		((id) => @service.game_sessions.get id)
		# 	]
		#
		# @role = new nx.Cell
		# 	'<-': [
		# 		@game_session,
		# 		({game_master_id}) =>
		# 			if game_master_id.equals @id
		# 				GameRole.GAME_MASTER
		# 			else
		# 				GameRole.PLAYER
		# 	]
		#
		# @round = new nx.Cell
		#
		# @round_phase = new nx.Cell
		# 	'<-': [@round, ({round_phase}) -> round_phase]
		#
		# @puzzles = new nx.Cell
		# 	'<-': [@round, ({puzzles}) -> puzzles]
		#
		# @puzzle = new nx.Cell
		# 	'<-': [@round, ({puzzle}) -> puzzle]
		#
		# @countdown = new nx.Cell
		# @solution = new nx.Cell
		#
		# @disconnected = new nx.Cell
		# 	action: =>
		# 		@game_session.value?.remove_participant @

module.exports = Participant
