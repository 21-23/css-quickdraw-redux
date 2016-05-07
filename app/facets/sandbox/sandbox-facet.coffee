class SandboxFacet

	constructor: (sandbox) ->
		@entities =
			puzzle_data: sandbox.puzzle_data
			selector:    sandbox.remote.selector
			match:       sandbox.remote.match
			node_list:   sandbox.node_list

	destroy: (session) ->

module.exports = SandboxFacet
