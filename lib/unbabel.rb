require "net/http"
require "uri"
require "faraday"
require "json"

class Unbabel

  @@translation_properties = [
    :text, :target_language, :source_language, :type, :tone, :visibility,
    :public_url, :callback_url, :topics, :instructions, :uid, :text_format,
    :target_text, :origin, :client
  ]
  @@UNBABEL_SANDBOX_DOMAIN = 'http://sandbox.unbabel.com/tapi/v2/'
  @@UNBABEL_DOMAIN = 'https://unbabel.com/tapi/v2/'

  class Translation < Struct.new(*@@translation_properties)

    def self.from_hash(hash)
      new(*hash.values_at(*members))
    end

  end

  def initialize(username, apikey, sandbox=false)
    @username = username
    @apikey = apikey
    unbabel_endpoint_domain = sandbox ? @@UNBABEL_SANDBOX_DOMAIN : @@UNBABEL_DOMAIN
    unbabel_endpoint_domain = ENV['UNBABEL_URL'] if ENV['UNBABEL_URL']

    @conn = Faraday.new(:url => unbabel_endpoint_domain) do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end
  end

  def api_call(endpoint, params: nil, data: nil, method: 'get')
    params ||= {}
    data ||= {}
    if method == 'get'
      func = @conn.method(:get)
    elsif method == 'post'
      func = @conn.method(:post)
    elsif method == 'patch'
      func = @conn.method(:patch)
    end
    response = func.call do |req|
      req.url endpoint
      req.headers['Authorization'] = "ApiKey #{@username}:#{@apikey}"
      req.headers['Content-Type'] = "application/json"
      params.each do |k, v|
        req.params[k] = v
      end
      unless method == 'get'
        req.body = data.to_json
      end
    end
    response
  end

  def post_translations(*params)
    attributes = (params[2] || {}).clone
    translation = unless params.first.is_a? Translation
                    attributes[:text] = params[0]
                    attributes[:target_language] = params[1]
                    Translation.from_hash(attributes)
                  else
                    params.first
                  end
    data = translation.to_h
    return api_call('translation/', data: data, method: 'post')
  end

  def bulk_translations(*translations)
    data = { objects: translations.map(&:to_h) }
    return api_call('translation/', data: data, method: 'patch')
  end

  def query_translation(uid)
    return api_call("translation/#{uid}/",  method: 'get')
  end

end
