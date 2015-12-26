PatternViewModel = require './pattern.viewmodel'

class ComponentViewModel
	constructor: ->
		@string = new nx.Cell
			value: ''

		@match = new nx.Cell
			'<-': [
				@string
				(string) =>
					@items.value
						.reduce ((indexes, {pattern}, index) ->
							if string.indexOf(pattern) isnt -1
								indexes.concat index
							else
								indexes), []
			]

		@match_update = new nx.Cell
			'<-': [
				@match
				(match, old_match) ->
					set: match or []
					unset:
						if old_match?
							old_match.filter (index) -> match.indexOf(index) is -1
						else []
			]

		@match_update['->'] \
			(({set}) =>	set.map (index) => @items.value[index].is_matched),	-> yes

		@match_update['->'] \
			(({unset}) => unset.map (index) => @items.value[index].is_matched), -> no

		@patterns = new nx.Cell

		@items = new nx.Cell
			value: []
			'<-': [
				@patterns
				(patterns) ->
					patterns.map (pattern) -> new PatternViewModel pattern
			]

module.exports = ComponentViewModel
