urlUtils     = require '../common/utils/url-utils'

window.addEventListener 'load', ->
	do urlUtils.successLoginRedirect
