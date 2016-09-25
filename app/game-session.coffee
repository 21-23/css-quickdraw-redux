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

	set_current_puzzle_index: (puzzle_index) ->
		(session) ->
			session.current_puzzle_index = puzzle_index
			session

	set_round_phase: (round_phase) ->
		(session) ->
			session.round_phase = round_phase
			session

	toJSON: (session) ->
		json =
			current_puzzle_index: session.current_puzzle_index
			round_phase:          session.round_phase
			participants:         {}

		session.participants_by_id.forEach (participant, id) ->
			json.participants[id] = participant

		json

module.exports = GameSession
