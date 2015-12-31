module Unbabel
  class Topic < UnbabelHTTPClient
    API_METHOD = 'topic/'

    def list
      response = get(API_METHOD)
      render json: response.body
    end
  end
end
