$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'better_assert_difference'
require 'pry'
require 'minitest/autorun'

module BetterAssertDifference::TestHelpers
  def assert_failure_with_message(expected_message)
    begin
      yield
      fail "should fail with message : #{expected_message}"
    rescue StandardError => exception
      assert exception.is_a?(RuntimeError)
      assert_equal expected_message[0..-2], exception.message
    end
  end
end

Minitest::Test.include(BetterAssertDifference::TestHelpers)
