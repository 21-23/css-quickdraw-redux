TagViewModel = require './tag.viewmodel'

class MatchRendererViewModel
	constructor: ({puzzle, match}) ->
		tags = @tags = new nx.Cell
			'<-': [
				puzzle,
				({tags}) ->
					if tags
						tags.map (tag) -> new TagViewModel tag
					else
						[]
			]

		matchUpdate = new nx.Cell
		matchUpdate['<-'] match, (newMatch, oldMatch) ->
			set: newMatch.ids or []
			unset:
				if oldMatch?.ids?
					unless newMatch.ids
						oldMatch.ids
					else
						oldMatch.ids.filter (id) -> newMatch.ids.indexOf(id) is -1
				else []

		createMatchCellsPicker = (key) ->
			(command) ->
				command[key].map (id) -> tags.value[id].match

		matchUpdate['->'] createMatchCellsPicker('set'), -> yes
		matchUpdate['->'] createMatchCellsPicker('unset'), -> no

module.exports = MatchRendererViewModel
