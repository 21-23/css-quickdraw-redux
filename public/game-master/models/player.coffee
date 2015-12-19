class Player

	constructor: ({@id, @display_name}) ->
		@rounds = new nx.Collection
		@solution = new nx.Cell

module.exports = Player
