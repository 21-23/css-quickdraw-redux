{nx} = require 'nexus-node'
co   = require 'co'

Sandbox = require './facets/sandbox/sandbox'

GameSession = require './game-session'
{GameSessionModel} = require './common/models/game-session'

QuickDraw =

	do: (state, actions) ->
		co ->
			for action in actions
				state = yield action state
			state

	empty: ->
		game_session_by_id: null
		sandbox: null

	create_sandbox: (logger) ->
		(state) ->
			state.sandbox = new Sandbox logger
			state

	load_sessions: (state) ->
		GameSessionModel
			.find {}
			.populate 'puzzles'
			.exec (err, sessions) =>
				state.game_session_by_id = new Map sessions.map (session) =>
					[
						do session._id.toString,
						new GameSession session, state.sandbox
					]
				state

module.exports = QuickDraw
