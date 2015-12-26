class Scorekeeper

	constructor: ({@default_score}) ->

		@players = new Set
		@rounds = []

	patch_player: (player_id) ->
		for round in @rounds
			unless round[player_id]?
				round[player_id] = @default_score

	add_round: (round_data) ->
		round_score = {}
		for player_id, player_score of round_data
			round_score[player_id] = player_score
			@patch_player player_id
			@players.add player_id

		@players.forEach (id) =>
			unless round_score[id]?
				round_score[id] = @default_score

		@rounds.push round_score

	aggregate: ->
		score = {}
		@players.forEach (id) =>
			score[id] = 0
			for round in @rounds
				score[id] += round[id]
		score

module.exports = Scorekeeper

