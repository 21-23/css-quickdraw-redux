require 'nexus'
require 'es6-promise'
require 'fetch'

AppViewModel = require './view-models/app-viewmodel'
AppView      = require './views/app-view'
urlUtils     = require '../common/utils/url-utils'

ensureSessionId = ->
	sessionId = urlUtils.getParamValue urlUtils.getParamsString(location.search), 'id'

	if not sessionId
		console.log 'Unrecognizable session if (URL parameter [id]). Application may fail to start'

	sessionId

ensureAuth = ->
	fetch '/isAuthed', {
		credentials: 'same-origin'
	}
	.then (response) -> response.json()
	.then (auth) ->
		new Promise (resolve, reject) ->
			if auth and auth.isAuthed then do resolve else do reject

window.addEventListener 'load', ->
	sessionId = do ensureSessionId
	ensureAuth()
		.then ->
			window.app = new AppViewModel sessionId
			document.body.appendChild AppView(app).data.node
		.catch ->
			console.log 'Not authenticated user, redirect to login page'
			do urlUtils.goToQuickLogin
