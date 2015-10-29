class MatcherFacet

	constructor: (matcher) ->
		@entities =
			puzzle: matcher.puzzle
			selector: matcher.selector
			match: matcher.match

	init: (session) ->

	destroy: (session) ->

module.exports = MatcherFacet
