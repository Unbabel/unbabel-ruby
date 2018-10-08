# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'unbabel-sdk'
require 'pry'
require 'webmock/rspec'

WebMock.enable!
