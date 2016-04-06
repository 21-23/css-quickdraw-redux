require 'normalize.css'
require './styles/index.styl'
require '../common/fonts/families.styl'

require 'nexus'
#backspace-block should be replaced with more flexible npm module
#https://github.com/slorber/backspace-disabler
require 'backspace-block'

AppViewModel = require './view-models/app-viewmodel'
AppView      = require './views/app-view'

if not window.sessionId then location.href = location.origin

window.app = new AppViewModel window.sessionId
document.body.appendChild AppView(app).data.node
