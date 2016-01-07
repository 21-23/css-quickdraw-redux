ToggleListItemViewModel = require './toggle-list-item.viewmodel'

class ToggleListViewModel

	constructor: (options = {}) ->
		{item_viewmodel} = options
		item_viewmodel or= ToggleListItemViewModel
		@items = new nx.Cell
		@pick = new nx.Cell

		@toggles = new nx.Cell
			'<-': [
				@items
				(items) -> items.map (item) -> new item_viewmodel item
			]

		@toggle_update = new nx.Cell
			'<-': [
				@pick
				(pick, old_pick = []) ->
					set:   pick.filter (index) -> not (index in old_pick)
					unset: old_pick.filter (index) -> not (index in pick)
			]

		@toggle_update['->'] (@get_toggles 'set'), -> yes
		@toggle_update['->'] (@get_toggles 'unset'), -> no

	get_toggles: (key) ->
		(update) =>
			indexes = update[key]
			indexes.map (index) => @toggles.value[index].toggled

module.exports = ToggleListViewModel
