require 'normalize.css'
require './styles/index.styl'
require '../common/fonts/families.styl'

require 'nexus'

AppViewModel = require './view-models/app-viewmodel'
AppView      = require './views/app-view'

if not window.sessionId
	throw new Error 'Unrecognizable session if (URL parameter [id]). Application may fail to start'

window.app = new AppViewModel window.sessionId
document.body.appendChild AppView(app).data.node
