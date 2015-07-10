path		= require 'path'
webpack = require 'webpack'
WebpackNotifierPlugin = require 'webpack-notifier'

PUBLIC_DIRECTORY = path.join __dirname, 'public'

module.exports =

	context: __dirname

	resolve:
		alias:
			common: path.join PUBLIC_DIRECTORY, 'app/common'
		root: PUBLIC_DIRECTORY
		extensions: ['', '.js', '.coffee']
		modulesDirectories: ['lib']

	entry:
		'bundle-test': 'app/test.coffee'
		'bundle-app': 'app/app.coffee'

	output:
		path: path.join(__dirname, './public/dist')
		filename: '[name].js'

	devtool: 'source-map'

	plugins: [
		new webpack.NoErrorsPlugin # for example to prevent tests from passing when there are coffee-lint errors
		new WebpackNotifierPlugin
		new webpack.ResolverPlugin(
			new webpack.ResolverPlugin.DirectoryDescriptionFilePlugin 'bower.json', ['main']
		)
	]

	coffeelint:
		configFile: path.join __dirname, './coffee-lint.json'

	module:

		preLoaders: [
			{
				test: /\.coffee?$/
				loader: 'coffee-lint-loader'
			}
		]

		loaders: [
			{ test: /\.coffee$/, loader: 'coffee-loader', exclude: /lib/ }
			{
				test: /\.styl$/
				loader: 'style-loader!css-loader!stylus-loader'
			}
		]
