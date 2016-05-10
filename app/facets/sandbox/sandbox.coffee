{nx} = require 'nexus-node'

class Sandbox

	constructor: (@log) ->
		@memory = new Map

		@remote =
			selector: new nx.Cell
			match:    new nx.Cell

		@selector = new nx.Cell
			'->': [
				({selector, player_id}) =>
					if @memory.has selector
						match = @memory.get selector
						@log
							message: 'match_in_memory'
							selector: selector
							match: match
						match = @cloneMatch match, player_id
						@match.value = match
						[]
					else
						@log
							message: 'execute_match'
							selector: selector
						@remote.selector
			]

		@match = new nx.Cell
			'<-': [@remote.match]
			action: (match) =>
				@memory.set match.selector, match

		@puzzle_data = new nx.Cell
		@node_list = new nx.Cell
			action: => do @memory.clear

		@log 'sandbox created'

	cloneMatch: (match, player_id) ->
		matchClone =
			selector: match.selector
			result: match.result
			ids: do match.ids.slice
			player_id: player_id

		if match.banned
			matchClone.banned =
				character: match.banned.character
				at: match.banned.at

		matchClone

module.exports = Sandbox
