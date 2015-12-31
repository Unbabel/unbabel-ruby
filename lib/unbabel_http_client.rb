class UnbabelHTTPClient
  API_URI = 'https://unbabel.com/tapi/v2/'
  API_SANDBOX_URI = 'http://sandbox.unbabel.com/tapi/v2/'

  def initialize(sandbox: nil, username: nil, api_key: nil)
    @sandbox = sandbox    || Unbabel.configuration.sandbox
    @username = username  || Unbabel.configuration.username
    @api_key = api_key    || Unbabel.configuration.api_key
    @conn = init_http_client
  end

  def get(uri, params = {})
    @conn.get do |request|
      request.url uri
    end
  end

  def post(uri, params = {})
    @conn.post do |request|
      request.url uri
      request.body = params.to_json
    end
  end

  def render(json:)
    JSON.parse(json, {symbolize_names: true})
  end

  private

  def init_http_client
    Faraday.new(url: api_endpoint) do |faraday|
      faraday.request  :url_encoded
      faraday.adapter  :net_http
      faraday.headers['Authorization'] = "ApiKey #{@username}:#{@api_key}"
      faraday.headers['Content-Type'] = 'application/json'
    end
  end

  def api_endpoint
    @sandbox ? API_SANDBOX_URI : API_URI
  end
end
