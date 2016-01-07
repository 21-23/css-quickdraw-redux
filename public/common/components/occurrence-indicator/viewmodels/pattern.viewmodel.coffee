{nx} = require 'nexus'

class PatternViewModel

	constructor: (@pattern) ->
		@toggled = new nx.Cell value:no

module.exports = PatternViewModel
