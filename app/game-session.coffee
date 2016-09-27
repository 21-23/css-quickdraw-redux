RoundPhase = require 'cssqd-shared/models/round-phase'

GameSession =

	COUNTDOWN_DURATION: 3 * 1000
	ROUND_DURATION:     12 * 60 * 1000

	create: (data) ->
		{puzzles, game_master_id} = data

		game_master_id:       game_master_id
		raw_puzzles:          puzzles
		participants_by_id:   new Map
		current_puzzle_index: 0
		round_phase:          RoundPhase.WAIT_SCREEN
		start_countdown_time: null
		round_countdown_time: null

	add_participant: (participant) ->
		(session) ->
			id = do participant.id.toString
			session.participants_by_id.set id, participant
			session

	remove_participant: (participant) ->
		(session) ->
			id = do participant.id.toString
			session.participants_by_id.delete id
			session

	start_round: (puzzle_index) ->
		(session) ->
			session.current_puzzle_index = puzzle_index
			session.round_phase = RoundPhase.COUNTDOWN
			session.start_countdown_time = GameSession.COUNTDOWN_DURATION
			session.round_countdown_time = GameSession.ROUND_DURATION
			session

	start_countdown_tick: ->
		(session) ->
			session.start_countdown_time -= 1000
			session

	start_countdown_end: ->
		(session) ->
			session.round_phase = RoundPhase.IN_PROGRESS
			session

	round_countdown_tick: ->
		(session) ->
			session.round_countdown_time -= 1000
			session

	round_countdown_end: ->
		(session) ->
			session.round_phase = RoundPhase.FINISHED
			session

	toJSON: (session) ->
		json =
			current_puzzle_index: session.current_puzzle_index
			round_phase:          session.round_phase
			participants:         {}
			start_countdown_time: session.start_countdown_time

		session.participants_by_id.forEach (participant, id) ->
			json.participants[id] = participant

		json

module.exports = GameSession
