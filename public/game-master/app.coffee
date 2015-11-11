require 'nexus'

AppViewModel = require './view-models/app-viewmodel'
AppView      = require './views/app-view'

window.addEventListener 'load', ->
	app = new AppViewModel
	document.body.appendChild AppView(app).data.node
