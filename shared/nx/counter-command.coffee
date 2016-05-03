{nx} = require 'nexus'

module.exports =
	RETAIN: nx.Identity
	INCREASE: (x) -> x + 1
	DECREASE: (x) -> x - 1
