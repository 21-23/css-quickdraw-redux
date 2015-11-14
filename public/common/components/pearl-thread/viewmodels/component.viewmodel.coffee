PearlViewModel = require './pearl.viewmodel'

class ComponentViewModel
	constructor: (items, view_model = PearlViewModel) ->
		@pearls = items.map (item) -> new view_model item

module.exports = ComponentViewModel
