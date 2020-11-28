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

  spec.post_install_message = %q{
    This new version requires an explicit `require` to be added to your test_helper.rb or spec_helper.rb

    # For Rails
    require 'better_assert_difference/rails_support'
    # For MiniTest
    require 'better_assert_difference/minitest_support'
    # For RSpec
    require 'better_assert_difference/rspec_support'
  }

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rspec', '~> 3.10'
  spec.add_development_dependency 'pry'
end
