# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name          = "holla_back"
  gem.version       = `cat VERSION`.strip
  gem.authors       = ["David Chapman"]
  gem.email         = ["david@dchapman.io"]
  gem.description   = %q{A simple Ruby gem for providing a response standard to your libraries}
  gem.summary       = %q{HollaBack will simply provide a unified response object containing needed information and responses.}
  gem.homepage      = "http://dchapman.io/"
  gem.license       = "MIT"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|gem|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "bundler", "~> 1.3"
  gem.add_development_dependency "rake"
  gem.add_development_dependency 'minitest'
  gem.add_development_dependency 'minitest-matchers'
  gem.add_development_dependency 'minitest-reporters'
  gem.add_development_dependency 'pry'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'simplecov-rcov'
  gem.add_development_dependency 'yard'
  gem.add_development_dependency 'yardstick'
  gem.add_development_dependency 'redcarpet'
  gem.add_development_dependency 'guard-minitest'
  gem.add_development_dependency 'libnotify'
  gem.add_development_dependency 'mocha'
  gem.add_development_dependency 'version'
  gem.add_development_dependency 'turn'
  gem.add_development_dependency 'ansi'
end
