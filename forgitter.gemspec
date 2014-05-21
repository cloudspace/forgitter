# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'forgitter/version'

Gem::Specification.new do |spec|
  spec.name          = 'forgitter'
  spec.version       = Forgitter::VERSION
  spec.authors       = ['Adam Dunson', 'Jeremiah Hemphill']
  spec.email         = ['adam@cloudspace.com', 'jeremiah@cloudspace.com']
  spec.summary       = %q{.gitignore generator}
  spec.description   = %q{.gitignore generator}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rake'
end
