{ app, BrowserWindow, session } = require 'electron'
{ APP_BASE_URL } = require '../cssqd-config/constants'

window = null

do app.dock.hide

session_config =
	url: APP_BASE_URL
	name: 'koa:sess'
	value: 'eyJwYXNzcG9ydCI6eyJ1c2VyIjoic2FuZGJveCJ9fQ=='

app.on 'ready', ->
	window = new BrowserWindow show:false

	session.defaultSession.cookies.set session_config, (err) ->
		if err
			console.log err
		else
			window.loadURL "#{APP_BASE_URL}/sandbox.html"
			console.log 'cssqd:ready'
