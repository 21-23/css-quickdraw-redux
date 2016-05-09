class PuzzlesProgressViewModel
	constructor: (@puzzles, @current_index) ->
		@complete_percentage = new nx.Cell
			'<<-': [
					[ @puzzles, @current_index ],
					(puzzles, index) ->
						if puzzles? and index? and index >= 0
							100 * index / (puzzles.length - 1)
						else
							0
				]

		@puzzles_change = new nx.Cell
			'<<-': [
				[ @puzzles, @current_index ],
				(puzzles, current_index) ->
					[ puzzles, current_index ]
			]

	getPuzzleClass: (puzzle_index, current_index) ->
		if puzzle_index < current_index
			'-solved'
		else if puzzle_index is current_index
			'-current'
		else
			'-future'

	getPuzzleText: (puzzle_index, current_index, puzzle) ->
		if puzzle_index < current_index
			''
		else if puzzle_index is current_index
			puzzle.name
		else
			puzzle_index + 1

module.exports = PuzzlesProgressViewModel
