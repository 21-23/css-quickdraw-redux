setCookie = (name, value, hours) ->
	expires = ''

	if hours
		date = new Date(do Date.now + (hours * 60 * 60 * 1000))
		expires = '; expires=' + do date.toGMTString;

	document.cookie = (name + '=' + value + expires + '; path=/')

getCookie = (name) ->
	nameEQ = name + '='
	cookieParts = document.cookie.split ';'
	for part in cookieParts
		part = part.replace /^\s*|\s*$/g, ''
		if part.indexOf(nameEQ) is 0
			return part.substring nameEQ.length, part.length

	return null

removeCookie = (name) ->
	setCookie(name, '', -1)

module.exports = {
	setCookie
	getCookie
	removeCookie
}
