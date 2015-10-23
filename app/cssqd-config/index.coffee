path  = require 'path'

nconf = require 'nconf'
CSON  = require 'cson'

varsFolder = path.join __dirname, '..', '..', 'config', 'var'

CSONFormat =
	stringify: CSON.stringify.bind CSON
	parse: CSON.parseCSONString.bind CSON

CSSQDConfig = Object.create nconf
CSSQDConfig.env separator: '__'
CSSQDConfig.file 'environment',
	file: path.join varsFolder, "#{process.env.NODE_ENV}.cson"
	format: CSONFormat

CSSQDConfig.file 'settings',
	file: path.join varsFolder, 'settings.cson'
	format: CSONFormat

module.exports = CSSQDConfig
