{nx} = require 'nexus-node'
co   = require 'co'

GameSession = require './game-session'
Sandbox = require './facets/sandbox/sandbox'

QuickDraw =

	Prism: (zoom, unzoom) ->
		(state, actions) ->
			partial_state = QuickDraw.do (zoom state), actions
			state = unzoom state, partial_state
			state.cell.value = QuickDraw.toJSON state
			state

	Interval: (state, {tick_actions, end_actions, duration, tick, prism}) ->
		remaining = duration
		interval = setInterval (->
			remaining -= tick
			if remaining is 0
				clearInterval interval
				state = prism state, end_actions
			else
				state = prism state, tick_actions
			), tick

	do: (state, actions) ->
		for action in actions
			state = action state
		state

	toJSON: (state) ->
		json =
			game_sessions: {}

		game_sessions_by_id: state.game_sessions_by_id.forEach (game_session, id) ->
			json.game_sessions[id] = GameSession.toJSON game_session

		json

	init: (cell, game_sessions) ->
		->
			cell :cell
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

module.exports = QuickDraw
