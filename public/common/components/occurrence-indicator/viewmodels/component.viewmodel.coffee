ToggleList = require 'common/components/toggle-list'

PatternViewModel = require './pattern.viewmodel'

class ComponentViewModel
	constructor: ->
		toggle_list = new ToggleList.ViewModel
			item_viewmodel: PatternViewModel

		# in
		@patterns = toggle_list.items
		@string = new nx.Cell	value:''

		# out
		@items = toggle_list.toggles

		toggle_list.pick['<-'] @string,	(string) =>
			@patterns.value.reduce ((indexes, pattern, index) ->
				if string.indexOf(pattern) isnt -1
					indexes.concat index
				else
					indexes), []

module.exports = ComponentViewModel
