{ app, BrowserWindow, session } = require 'electron'
CSSQDConfig = require '../cssqd-config'

window = null

port = CSSQDConfig.get 'service:port'
app_url = "http://127.0.0.1:#{port}"

do app.dock?.hide

session_config =
	url: app_url
	name: 'koa:sess'
	value: 'eyJwYXNzcG9ydCI6eyJ1c2VyIjoic2FuZGJveCJ9fQ=='

app.on 'ready', ->
	window = new BrowserWindow show:false

	session.defaultSession.cookies.set session_config, (err) ->
		if err
			console.log err
		else
			window.loadURL "#{app_url}/sandbox.html"
			console.log 'cssqd-service:ready'
