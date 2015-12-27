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
		score = []
		@players.forEach (id) =>
			player_score =
				id: id
				score: 0
			for round in @rounds
				player_score.score += round[id]
			score.push player_score
		score.sort (first_score, second_score) ->
			first_score.score - second_score.score
		score

module.exports = Scorekeeper

