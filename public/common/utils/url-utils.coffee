cookieUtils = require './cookie-utils'

module.exports = {
	getParamsString: (search) -> search.substring 1

	getParamValue: (paramsStr, paramName) ->
		params = paramsStr.split '&'
		for param in params
			[key, value] = param.split '='
			return decodeURIComponent value or '' if key is paramName

	goToQuickLogin: ->
		cookieUtils.setCookie 'successLoginRedirect', location.href, 1
		location.href = 'quick-login.html'

	successLoginRedirect: ->
		url = cookieUtils.getCookie 'successLoginRedirect'
		if url
			cookieUtils.removeCookie 'successLoginRedirect'
		else
			url = '/'

		location.href = url
}
