Gem::Specification.new do |s|
  s.name        = 'unbabel-ruby'
  s.version     = '0.0.1'
  s.date        = '2014-11-14'
  s.summary     = "Unbabel ruby wrapper"
  s.description = ""
  s.authors     = ["Sam Hopkins", "Diogo Rosa"]
  s.email       = 'sam@unbabel.com'
  s.files       = ["lib/unbabel.rb"]
  s.require_paths = ["lib"]
  s.homepage    = 'http://unbabel.com'
  s.license      = 'LGPL'
  s.add_runtime_dependency 'faraday'
  s.add_runtime_dependency 'json'
end