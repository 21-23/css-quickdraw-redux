{nx} = require 'nexus'

class PearlViewModel

	constructor: ({color, text}) ->
		@color = new nx.Cell value:color
		@text = new nx.Cell value:text

module.exports = PearlViewModel
