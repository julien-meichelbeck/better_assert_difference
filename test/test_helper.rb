$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'active_record/base'
require 'dummy/fruit'
require 'better_assert_difference'
require 'pry'
require 'minitest/autorun'

module BetterAssertDifference::TestHelpers
  def assert_failure_with_message(expected_message, exception_class = MiniTest::Assertion)
    begin
      yield
      fail "should fail with message : #{expected_message}"
    rescue exception_class => exception
      assert_equal expected_message[0..-2], exception.message
    end
  end

  def teardown
    ActiveRecord::Base.reset_count
  end
end

Minitest::Test.include(BetterAssertDifference::TestHelpers)
