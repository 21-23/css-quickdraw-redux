path = require 'path'

PUBLIC_DIRECTORY = path.join __dirname, 'public'
ENTRY = path.join PUBLIC_DIRECTORY, 'test.coffee'

module.exports = (config) ->
	config.set

		browsers: ['Electron']
		frameworks: ['mocha', 'chai-sinon']
		files: [ENTRY]

		preprocessors:
			"#{ENTRY}": ['webpack']

		webpack: require './webpack.config.coffee'

		plugins: [
			'karma-chai-sinon'
			'karma-mocha'
			'karma-webpack'
			'karma-electron-launcher'
		]
