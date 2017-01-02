# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'better_assert_difference/version'

Gem::Specification.new do |spec|
  spec.name          = 'better_assert_difference'
  spec.version       = BetterAssertDifference::VERSION
  spec.authors       = ['Julien Meichelbeck']
  spec.email         = ['julien.meichelbeck@gmail.com']

  spec.summary       = 'assert_difference, but better.'
  spec.description   = 'Call assert_difference with ActiveRecord_Relation objects, arrays or hashes.'
  spec.homepage      = 'https://github.com/julien-meichelbeck/better_assert_difference'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
end
