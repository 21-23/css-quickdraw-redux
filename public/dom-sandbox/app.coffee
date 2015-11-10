require 'nexus'

AppViewModel = require './view-models/app-viewmodel'

window.addEventListener 'load', ->
	app = new AppViewModel
