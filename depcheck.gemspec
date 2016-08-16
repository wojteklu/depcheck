# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'depcheck/version'

Gem::Specification.new do |spec|
  spec.name          = 'depcheck'
  spec.version       = Depcheck::VERSION
  spec.authors       = ['Wojciech Lukaszuk']
  spec.email         = ['wojciech.lukaszuk@icloud.com']
  spec.summary       = 'Dependency analyzer tool for Swift projects'
  spec.homepage      = 'https://github.com/wojteklu/depcheck'
  spec.license       = 'MIT'
  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake', '~> 10.4'
  spec.add_development_dependency 'rspec', '~> 3.4'

  spec.add_dependency 'clamp', '~> 0.6'

end
