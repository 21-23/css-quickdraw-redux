ToggleList = require 'common/components/toggle-list'
TagViewModel = require './tag.viewmodel'

class MatchRendererViewModel
	constructor: ->
		toggle_list = new ToggleList.ViewModel
			item_viewmodel: TagViewModel

		# in
		@match = new nx.Cell
		@tag_list = toggle_list.items

		# out
		@tags = toggle_list.toggles

		toggle_list.pick['<-'] @match, ({ids}) -> ids

module.exports = MatchRendererViewModel
