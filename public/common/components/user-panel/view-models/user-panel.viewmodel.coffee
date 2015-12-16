class UserPanelViewModel
	constructor: (userData) ->
		@name = new nx.Cell
			'<-': [
				userData,
				(userInfo) ->
					userInfo.displayName
			]

module.exports = UserPanelViewModel
