# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'logfmt_marshalling/version'

Gem::Specification.new do |spec|
  spec.name          = 'logfmt_marshalling'
  spec.version       = LogfmtMarshalling::VERSION
  spec.authors       = ['Pavel Mitin']
  spec.email         = ['mitin.pavel@gmail.com']
  spec.summary       = %q{A Ruby gem for emitting strings in logfmt logging format.}
  spec.description   = %q{A Ruby gem for emitting strings in logfmt logging format. Check out https://brandur.org/logfmt to get more information about logfmt key-value structured logging.}
  spec.homepage      = 'https://github.com/MitinPavel/logfmt_marshalling'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake', '~> 10.4'
  spec.add_development_dependency 'rspec', '~> 3.1'
end
