class MatchRendererViewModel
	constructor: ({node_list, match}) ->
		tags = @tags = new nx.Cell
			'<-': [
				node_list,
				(nodes) ->
					if nodes
						nodes.map ({type, element, attrs, text, objective}) ->
							type: type
							element: element
							attrs: attrs
							text: text
							objective: objective
							match: new nx.Cell
					else
						[]
			]

		matchUpdate = new nx.Cell
		matchUpdate['<-'] match, (newMatch, oldMatch) ->
			unset = if oldMatch
				oldMatch.ids.filter (id) -> newMatch.ids.indexOf(id) is -1
			else []

			set: newMatch.ids
			unset: unset

		createMatchCellsPicker = (key) ->
			(command) ->
				command[key].map (id) -> tags.value[id].match

		matchUpdate['->'] createMatchCellsPicker('set'), -> yes
		matchUpdate['->'] createMatchCellsPicker('unset'), -> no

module.exports = MatchRendererViewModel
