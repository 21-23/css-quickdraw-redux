AppView = (context) ->
	nxt.Element 'div',
		nxt.Binding context.puzzles, (puzzles) ->
			nxt.Element 'div',
				puzzles?.map (puzzle, index) ->
					nxt.Element 'div',
						nxt.Text puzzle.name
						nxt.Event 'click', context.current_puzzle_index, -> index
		nxt.Element 'div',
			nxt.Binding context.round_phase, nxt.Text
		nxt.Element 'div',
			nxt.Binding context.countdown, nxt.Text

		nxt.Element 'div',
			nxt.Text 'Players:'
		nxt.Collection context.players, (player) ->
			nxt.Text player.displayName

module.exports = AppView
