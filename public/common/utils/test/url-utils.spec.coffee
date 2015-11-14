urlUtils = require '../url-utils'

describe 'urlUtils', ->

	describe 'getParamsString', ->

		it 'returns the correct params string from location.search', ->
			locationSearch = '?code=spectre&operation=pig%20pegga'
			urlUtils.getParamsString(locationSearch).should.equal 'code=spectre&operation=pig%20pegga'

	describe 'getParamValue', ->

		it 'returns the value of param by its name from given params string', ->
			paramsStr = 'code=spectre&operation=pig%20pegga'
			urlUtils.getParamValue(paramsStr, 'code').should.equal 'spectre'
			urlUtils.getParamValue(paramsStr, 'operation').should.equal 'pig pegga'

		it 'returns empty string for params without value', ->
			paramsStr = 'code&operation=pig%20pegga&enabled'
			urlUtils.getParamValue(paramsStr, 'code').should.equal ''
			urlUtils.getParamValue(paramsStr, 'enabled').should.equal ''

		it 'returns undefined for params that are not in params string', ->
			paramsStr = 'code=skyfall&operation=pig%20pegga'
			should.equal urlUtils.getParamValue(paramsStr, 'symbol'), undefined
