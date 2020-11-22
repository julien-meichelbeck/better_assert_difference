$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require_relative '../test/active_record/base'
require_relative '../test/dummy/fruit'
require 'better_assert_difference'
require 'better_assert_difference/rspec_support'
require 'pry'
require 'rspec'

module BetterAssertDifference::TestHelpers
  def assert_failure_with_message(expected_message, exception_class = RSpec::Expectations::ExpectationNotMetError)
    begin
      yield
      fail "should fail with message : #{expected_message}"
    rescue exception_class => exception
      expect(expected_message[0..-2]).to eq(exception.message)
    end
  end
end

RSpec.configure do |config|
  config.include BetterAssertDifference
  config.include BetterAssertDifference::TestHelpers
  config.after(:each) do
    ActiveRecord::Base.reset_count
  end
end
