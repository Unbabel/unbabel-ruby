lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name        = 'unbabel-ruby'
  gem.version     = '1.0'
  gem.date        = '2014-11-14'
  gem.summary     = "Unbabel ruby wrapper"
  gem.description = ""
  gem.authors     = ['Sam Hopkins', 'Diogo Rosa', 'Bryan FRIMIN (gearnode)']
  gem.email       = 'sam@unbabel.com'
  gem.homepage    = 'http://unbabel.com'
  gem.license     = 'LGPL'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(spec)/})
  gem.require_paths = ['lib']

  gem.add_runtime_dependency 'rake', '~> 10.4', '>= 10.4'
  gem.add_runtime_dependency 'faraday'
  gem.add_runtime_dependency 'json'

  gem.add_development_dependency 'bundler', '~> 1.7'
  gem.add_development_dependency 'rspec', '~> 3.1'
  gem.add_development_dependency 'pry', '~> 0.10'
end
