require 'nexus'

AppViewModel = require './view-models/app-viewmodel'

window.addEventListener 'load', ->
	document.cookie = 'koa:sess=eyJwYXNzcG9ydCI6eyJ1c2VyIjoic2FuZGJveCJ9fQ=='
	app = new AppViewModel
