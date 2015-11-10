class SandboxFacet

	constructor: (sandbox) ->
		@entities =
			puzzle_data: sandbox.puzzle_data
			selector: sandbox.selector
			match: sandbox.match

	init: (session) ->

	destroy: (session) ->

module.exports = SandboxFacet
