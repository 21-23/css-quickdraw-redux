path = require 'path'

PUBLIC_DIRECTORY = path.join __dirname, 'public'
ENTRY = path.join PUBLIC_DIRECTORY, 'app/test.coffee'

module.exports = (config) ->
	config.set

		browsers: [if process.env.TRAVIS then 'Chrome_Travis' else 'PhantomJS2']

		customLaunchers:
			Chrome_Travis:
				base: 'Chrome'
				flags: ['--no-sandbox']

		frameworks: ['mocha', 'chai-sinon']

		files: [ENTRY]

		preprocessors:
			"#{ENTRY}": ['webpack']

		webpack: require './webpack.config.coffee'

		plugins: [
			'karma-chai-sinon'
			'karma-mocha'
			'karma-webpack'
			'karma-phantomjs2-launcher'
			'karma-chrome-launcher'
		]
