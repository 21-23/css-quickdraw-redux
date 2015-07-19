PatternViewModel = require './pattern.viewmodel'

class ComponentViewModel
	constructor: (patterns) ->
		@string = new nx.Cell value: ''
		@patterns = patterns.map (pattern) => new PatternViewModel pattern, @string

module.exports = ComponentViewModel
