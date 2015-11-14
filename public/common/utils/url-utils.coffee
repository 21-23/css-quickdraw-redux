cookieUtils = require './cookie-utils'

module.exports = {
	getParamsString: (search) -> search.substring 1

	getParamValue: (paramsStr, paramName) ->
		params = paramsStr.split '&'
		for param in params
			pair = param.split '='
			return decodeURIComponent pair[1] or '' if pair[0] is paramName

		return undefined

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
