require 'nexus'

AppView = require './views/app-view'
AppViewModel = require './view-models/app-viewmodel'

window.addEventListener 'load', ->
	app = new AppViewModel
	document.body.appendChild AppView(app).data.node
