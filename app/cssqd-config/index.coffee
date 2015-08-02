path  = require 'path'

nconf = require 'nconf'
CSON  = require 'cson'

CSONFormat =
	stringify: CSON.stringify.bind CSON
	parse: CSON.parseCSONString.bind CSON

CSSQDConfig = Object.create nconf

CSSQDConfig.useDir = (directory) ->
		nconf.file 'environment',
			file: path.join directory, "#{process.env.NODE_ENV}.cson"
			format: CSONFormat

		nconf.file 'settings',
			file: path.join directory, 'settings.cson'
			format: CSONFormat

module.exports = CSSQDConfig
