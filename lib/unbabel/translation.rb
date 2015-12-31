module Unbabel
  class Translation < UnbabelHTTPClient
    API_METHOD = 'translation/'

    def list(status)
      response = get(API_METHOD + '?status=' + status.to_s)
      render json: response.body
    end

    def create(text, target_language, args = {})
      args = defaults_create_params.
        merge(args).
        merge(text: text).
        merge(target_language: target_language)

      response = post(API_METHOD, args)
      render json: response.body
    end

    def retrieve(uid)
      response = get(API_METHOD + uid + '/')
      render json: response.body
    end

    private

    def defaults_create_params
      {
        source_language: nil,
        target_text: nil,
        text_format: nil,
        uid: nil,
        callback_url: nil,
        tone: nil,
        instructions: nil,
        topics: nil
      }
    end
  end
end
