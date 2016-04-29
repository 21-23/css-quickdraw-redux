CSSQDConfig = require './'

https = CSSQDConfig.get 'service:https'
protocol = if https then 'https' else 'http'

host = CSSQDConfig.get 'service:host'
port = CSSQDConfig.get 'service:port'

authPath = CSSQDConfig.get 'service:auth:url'

exports.APP_BASE_URL = "#{protocol}://#{host}:#{port}"
