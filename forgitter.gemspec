# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'forgitter/version'

Gem::Specification.new do |spec|
  spec.name          = 'forgitter'
  spec.version       = Forgitter::VERSION
  spec.authors       = ['Adam Dunson', 'Jeremiah Hemphill']
  spec.email         = ['adam@cloudspace.com', 'jeremiah@cloudspace.com']
  spec.summary       = %q{Forgitter is a .gitignore generator.}
  spec.description   = %q{Forgitter is a .gitignore generator. It is based on the ignorefiles found at https://github.com/github/gitignore.}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  gem_dir = File.expand_path(File.dirname(__FILE__)) + '/'
  `git submodule --quiet foreach pwd`.split($\).each do |submodule_path|
    Dir.chdir(submodule_path) do
      submodule_relative_path = submodule_path.sub gem_dir, ''
      # issue git ls-files in submodule's directory and
      # prepend the submodule path to create absolute file paths
      `git ls-files`.split($\).each do |filename|
        spec.files << "#{submodule_relative_path}/#{filename}"
      end
    end
  end

  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'debugger'
end
