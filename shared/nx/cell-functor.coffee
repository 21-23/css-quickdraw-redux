{nx} = require 'nexus'

module.exports = ({cell, map}) ->
	cell = new nx.Cell cell
	map = new nx.Cell map
	map['->'] cell, (map) -> map cell.value
	cell
