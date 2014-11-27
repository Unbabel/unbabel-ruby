#require "rubygems"
require "net/http"
require "uri"
require "faraday"
require "json"

class Unbabel

  @@UNBABEL_SANDBOX_DOMAIN = 'http://sandbox.unbabel.com/tapi/v2/'
  @@UNBABEL_DOMAIN = 'https://unbabel.com/tapi/v2/'


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
    end
    response = func.call do |req|
      req.url endpoint
      req.headers['Authorization'] = "ApiKey #{@username}:#{@apikey}"
      req.headers['Content-Type'] = "application/json"
      params.each do |k, v|
        req.params[k] = v
      end
      unless method == 'get'
        puts data.to_json
        req.body = data.to_json
      end
    end
    response
  end

  def post_translations(text, target_language, source_language: nil, type: nil, tone: nil, 
                        visibility: nil, public_url: nil, callback_url: nil, topics: [],
                        instructions: nil, uid: nil, text_format: "text", target_text: nil,
                        origin: nil)
    data = {
      text: text, 
      target_language: target_language, 
      source_language: source_language,
      type: type,
      tone: tone,
      visibility: visibility,
      public_url: public_url,
      callback_url: callback_url,
      topics: topics,
      instructions: instructions,
      uid: uid,
      text_format: text_format,
      target_text: target_text,
      origin: origin
    }
    return api_call('translation/', data: data, method: 'post')
  end
  
end
