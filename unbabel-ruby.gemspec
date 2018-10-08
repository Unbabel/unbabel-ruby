# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'unbabel-sdk/version'

Gem::Specification.new do |spec|
  spec.name          = 'unbabel-ruby'
  spec.version       = UnbabelSDK::VERSION
  spec.authors       = ['Sam Hopkins', 'Diogo Rosa']
  spec.email         = ['sam@unbabel.com']

  spec.summary       = 'Ruby SDK for the Unbabel REST API'
  spec.description   = ''
  spec.homepage      = 'http://unbabel.com'
  spec.license       = 'LGPL'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'faraday', '~> 0.15'
  spec.add_runtime_dependency 'json', '2.1'

  spec.add_development_dependency 'pry', '~> 0.11'
  spec.add_development_dependency 'rspec', '~> 3.8'
  spec.add_development_dependency 'rubocop', '~> 0.59'
  spec.add_development_dependency 'webmock', '~> 3.4'
end
