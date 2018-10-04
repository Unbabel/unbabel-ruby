$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'unbabel-sdk'
require 'pry'
require 'webmock/rspec'

WebMock.enable!