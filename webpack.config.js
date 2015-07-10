var path = require('path');
var webpack = require('webpack');


module.exports = {

	context: __dirname,

	resolve: {
		root: [path.join(__dirname, './public')],
		extensions: ['', '.js', '.coffee'],
		modulesDirectories: ['lib']
	},

	entry: {
		'bundle-test': 'app/test.coffee',
		'bundle-app': 'app/app.coffee'
	},

	output: {
		path: path.join(__dirname, './public/dist'),
		filename: '[name].js'
	},

	devtool: 'source-map',

	plugins: [
		new webpack.ResolverPlugin(
			new webpack.ResolverPlugin.DirectoryDescriptionFilePlugin('bower.json', ['main'])
		)
	],

	module: {
		loaders: [
			{ test: /\.coffee$/, loader: 'coffee-loader', exclude: /lib/ },
			{
				test: /\.styl$/,
    		loader: 'style-loader!css-loader!stylus-loader'
  		}
		]
	}
};
