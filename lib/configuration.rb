class Configuration
  attr_accessor :username, :api_key, :sandbox

  def initialize
    @username = username
    @api_key  =  api_key
    @sandbox  = false
  end
end
