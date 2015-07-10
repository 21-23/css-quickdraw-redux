{nx} = require 'nexus'

class PearlViewModel

	constructor: ({modifier, text}) ->
		@modifier = new nx.Cell value:modifier
		@text = new nx.Cell value:text

module.exports = PearlViewModel
