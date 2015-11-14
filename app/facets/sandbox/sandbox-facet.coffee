class SandboxFacet

	constructor: (sandbox) ->
		@entities =
			puzzle_data: sandbox.puzzle_data
			selector:    sandbox.selector
			match:       sandbox.match
			node_list:   sandbox.node_list

	init: (session) ->

	destroy: (session) ->

module.exports = SandboxFacet
