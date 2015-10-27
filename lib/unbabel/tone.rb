module Unbabel
  class Tone < UnbabelHTTPClient
    API_METHOD = 'tone/'

    def list
      response = get(API_METHOD)
      render json: response.body
    end
  end
end
