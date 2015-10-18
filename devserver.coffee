cson             = require 'cson'
WebpackDevServer = require 'webpack-dev-server'
webpack          = require 'webpack'
webpackConfig    = require './webpack.config'

appConfig = cson.requireCSONFile './config/settings.cson'
wdsPort = 8080
compiler = webpack webpackConfig

server = new WebpackDevServer compiler,
	contentBase: '/public/dist/'
	hot: yes
	proxy:
		'*': "http://localhost:#{appConfig.service.port}"
	quiet: no

server.listen wdsPort, 'localhost', ->
	console.log "Webpack Dev Server is listening on http://localhost:#{wdsPort}"
