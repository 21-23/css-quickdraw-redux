var path = require('path');
var webpack = require('webpack');

module.exports = {

	context: __dirname,

	resolve: {
		root: [path.join(__dirname, 'lib')],
		extensions: ['', '.js', '.coffee']
	},

	entry: {
		'bundle-test': './test.coffee'
	},

	output: {
		path: path.join(__dirname, 'dist'),
		filename: '[name].js'
	},

	devtool: 'source-map',

	plugins: [
		new webpack.ResolverPlugin(
			new webpack.ResolverPlugin.DirectoryDescriptionFilePlugin("bower.json", ["main"])
		)
	],

	module: {
		loaders: [
			{ test: /\.coffee$/, loader: 'coffee-loader', exclude: /lib/ }
		]
	}
};

