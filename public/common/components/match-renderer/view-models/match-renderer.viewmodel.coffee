class MatchRendererViewModel
	constructor: ({node_list, match}) ->
		@tags = new nx.Cell
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
							matchType: new nx.Cell
					else
						[]
			]

		new nx.Cell
			'<-': [
				match,
				(newMatch, oldMatch) ->
					console.log newMatch, oldMatch
					if oldMatch
						matchesToDelete = oldMatch.ids.filter (id) -> newMatch.ids.indexOf(id) is -1

					console.log matchesToDelete
			]

	resetMatchedTags: =>
		if @tags.value.length > 0
			@setMatchedTags [0..@tags.value.length - 1], no

	setMatchedTags: (ids, value) =>
		ids.forEach (id) => @tags.value[id].matchType.value = value

module.exports = MatchRendererViewModel
