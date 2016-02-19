{nx} = require 'nexus'

module.exports = ->
	[cells..., conversion] = arguments
	cascade = new nx.Cell
	acc = new nx.Cell
		value: []
		'->': [
			((values) ->
				if values.length is cells.length then cascade else []),
				(values) -> conversion values...
			]

	cells.forEach (cell, index) ->
		cell['->'] acc, (value) ->
			acc.value.splice(0, index).concat value

	cascade
