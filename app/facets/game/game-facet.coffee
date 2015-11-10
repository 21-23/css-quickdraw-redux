class GameFacet

	constructor: (game) ->
		@entities =
			selector: game.selector
			match:    game.match

	init: (session) ->

	destroy: (session) ->

module.exports = GameFacet
