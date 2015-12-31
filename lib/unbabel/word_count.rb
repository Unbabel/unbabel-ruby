module Unbabel
  class WordCount < UnbabelHTTPClient
    API_METHOD = 'wordcount/'

    def count(text)
      response = post(API_METHOD, {text: text})
      render json: response.body
    end
  end
end
