require 'nexus'

AppViewModel = require './view-models/app-viewmodel'
AppView      = require './views/app-view'
urlutils     = require '../common/utils/url-utils'

window.addEventListener 'load', ->
	sessionId = urlutils.getParamValue urlutils.getParamsString(location.search), 'id'

	if not sessionId
		console.log 'Unrecognizable session if (URL paramter [id]). Application may fail to start'

	app = new AppViewModel sessionId
	document.body.appendChild AppView(app).data.node
