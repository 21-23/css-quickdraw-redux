class SandboxFacet

	constructor: (sandbox) ->
		@entities =
			puzzle: sandbox.puzzle
			selector: sandbox.selector
			match: sandbox.match

	init: (session) ->

	destroy: (session) ->

module.exports = SandboxFacet
