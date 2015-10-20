# all resources accessible without authentication should be placed here

authRouter = require './auth'

Router = require 'koa-router'
router = new Router

router.use authRouter.middleware()

module.exports = router
