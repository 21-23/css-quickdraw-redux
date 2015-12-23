class UserPanelViewModel
	constructor: (userData) ->
		@name = new nx.Cell
			'<-': [
				userData,
				(userInfo) ->
					userInfo.display_name
			]

module.exports = UserPanelViewModel
