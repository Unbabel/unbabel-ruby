require 'json'
require 'faraday'
require 'unbabel_http_client'
require 'configuration'

module Unbabel
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  autoload :Language, 'unbabel/language'
  autoload :Translation, 'unbabel/translation'
  autoload :Tone, 'unbabel/tone'
  autoload :Topic, 'unbabel/topic'
  autoload :WordCount, 'unbabel/word_count'
end
