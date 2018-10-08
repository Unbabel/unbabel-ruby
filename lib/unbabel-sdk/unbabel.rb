# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'faraday'
require 'json'

class Unbabel
  UNBABEL_SANDBOX_DOMAIN = 'https://sandbox.unbabel.com/tapi/v2/'
  UNBABEL_DOMAIN = 'https://unbabel.com/tapi/v2/'

  private_constant :UNBABEL_SANDBOX_DOMAIN, :UNBABEL_DOMAIN

  def initialize(username, apikey, sandbox = false)
    @username = username
    @apikey = apikey
    @conn = connection(sandbox)
  end

  def api_call(endpoint, params: {}, data: {}, method: 'get')
    function(method).call do |resp|
      resp.url(endpoint)
      resp.headers['Authorization'] = "ApiKey #{@username}:#{@apikey}"
      resp.headers['Content-Type'] = 'application/json'

      params.each { |key, value| resp.params[key] = value }
      resp.body = data.to_json unless method == 'get'
    end
  end

  def post_translations(text, target_language:, source_language:, options: {})
    data = post_body_request(text, target_language, source_language, options)
    api_call('translation/', data: data, method: 'post')
  end

  def query_translation(uid)
    api_call("translation/#{uid}/", method: 'get')
  end

  private

  def post_body_request(text, target_language, source_language, options)
    {
      text: text, target_language: target_language,
      source_language: source_language, type: options['type'],
      tone: options['tone'], visibility: options['visibility'],
      public_url: options['public_url'], callback_url: options['callback_url'],
      topics: options['topics'] || [], instructions: options['instructions'],
      uid: options['uid'], text_format: options['text_format'] || 'text',
      target_text: options['target_text'], origin: options['origin']
    }
  end

  def function(method)
    return @conn.method(:get) if method == 'get'
    return @conn.method(:post) if method == 'post'

    raise "Method: #{method} not allowed"
  end

  def connection(sandbox)
    unbabel_endpoint_domain = sandbox ? UNBABEL_SANDBOX_DOMAIN : UNBABEL_DOMAIN

    Faraday.new(url: unbabel_endpoint_domain) do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end
  end
end
