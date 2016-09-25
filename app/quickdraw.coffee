{nx} = require 'nexus-node'
co   = require 'co'

GameSession = require './game-session'
Sandbox = require './facets/sandbox/sandbox'

QuickDraw =

	Prism: (zoom) ->
		(state, actions) ->
			QuickDraw.do (zoom state), actions
			state

	do: (state, actions) ->
		for action in actions
			state = action state
		state

	init: (game_sessions) ->
		->
			game_sessions_by_id: new Map game_sessions.map (game_session) ->
				[
					do game_session._id.toString,
					GameSession.create game_session
				]
			sandbox: null

	create_sandbox: (logger) ->
		(state) ->
			state.sandbox = new Sandbox logger
			state

	toJSON: (state) ->
		json =
			game_sessions: {}

		game_sessions_by_id: state.game_sessions_by_id.forEach (game_session, id) =>
			json.game_sessions[id] = GameSession.toJSON game_session

		json

module.exports = QuickDraw
