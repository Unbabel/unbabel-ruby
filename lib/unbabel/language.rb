module Unbabel
  class Language < UnbabelHTTPClient
    API_METHOD = 'language_pair/'

    def language_pair
      response = get(API_METHOD)
      render json: response.body
    end
  end
end
