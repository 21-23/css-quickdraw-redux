{nx} = require 'nexus-node'

class Sandbox

	constructor: ->
		@selector = new nx.Cell
		@puzzle_data = new nx.Cell
		@match = new nx.Cell
		@node_list = new nx.Cell

module.exports = Sandbox
