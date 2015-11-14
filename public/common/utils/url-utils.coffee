module.exports = {
	getParamsString: (search) -> search.substring 1

	getParamValue: (paramsStr, paramName) ->
		params = paramsStr.split '&'
		for param in params
			pair = param.split '='
			return decodeURIComponent pair[1] or '' if pair[0] is paramName

		return undefined
}
