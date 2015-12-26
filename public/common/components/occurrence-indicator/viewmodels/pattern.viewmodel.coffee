{nx} = require 'nexus'

class PatternViewModel

	constructor: (@pattern) ->
		@is_matched = new nx.Cell value:no

module.exports = PatternViewModel
