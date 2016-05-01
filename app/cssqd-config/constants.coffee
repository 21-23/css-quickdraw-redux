CSSQDConfig = require './'

https = CSSQDConfig.get 'service:https'
protocol = if https then 'https' else 'http'

host = CSSQDConfig.get 'service:host'
port = CSSQDConfig.get 'service:port'

authPath = CSSQDConfig.get 'service:auth:url'

APP_BASE_URL = "#{protocol}://#{host}"

unless process.env.NODE_ENV is 'prod'
	APP_BASE_URL = "#{APP_BASE_URL}:#{port}"

exports.APP_BASE_URL = APP_BASE_URL
