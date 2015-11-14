cookieUtils = require '../cookie-utils'

describe 'cookieUtils', ->

	describe 'getCookie', ->

		it 'gets cookies value correctly', ->
			document.cookie = 'code=spectre'
			cookieUtils.getCookie('code').should.equal 'spectre'

		it 'returns null for non-existing cookie', ->
			should.equal cookieUtils.getCookie('nonExisting'), null

	describe 'setCookie', ->

		it 'sets cookies value correctly', ->
			cookieUtils.setCookie('symbol', 'a')
			cookieUtils.getCookie('symbol').should.equal 'a'

	describe 'removeCookie', ->

		it 'removes cookie', ->
			cookieUtils.setCookie('symbol', 'a')
			cookieUtils.getCookie('symbol').should.equal 'a'
			cookieUtils.removeCookie('symbol')
			should.equal cookieUtils.getCookie('symbol'), null
