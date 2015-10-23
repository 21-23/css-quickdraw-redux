configureRoutes = require './routes'
configureKoa    = require './koa'

module.exports =
	configureRoutes: configureRoutes
	configureKoa   : configureKoa
