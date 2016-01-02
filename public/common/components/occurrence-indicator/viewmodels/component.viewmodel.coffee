ToggleList = require 'common/components/toggle-list'

PatternViewModel = require './pattern.viewmodel'

class ComponentViewModel
	constructor: ->
		toggle_list = new ToggleList.ViewModel
			item_viewmodel: PatternViewModel

		@patterns = toggle_list.items
		@items = toggle_list.toggles

		@string = new nx.Cell
			value: ''

		toggle_list.pick['<-'] @string,	(string) =>
			@patterns.value.reduce ((indexes, pattern, index) ->
				if string.indexOf(pattern) isnt -1
					indexes.concat index
				else
					indexes), []

module.exports = ComponentViewModel
