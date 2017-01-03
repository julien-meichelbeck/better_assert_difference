require 'test_helper'

class BetterAssertDifferenceTest < Minitest::Test
  include BetterAssertDifference

  def setup
    @items = []
  end

  def test_multiple_expressions_success
    assert_difference([@items, '@items.count', -> { @items.count }]) do
      @items << 1
    end
  end

  def test_single_expression_failure
    error_message = <<~FAIL_MSG
      \"@items.count\" didn't change by 1
    FAIL_MSG
    assert_failure_with_message(error_message) do
      assert_difference('@items.count') { }
    end
  end

  def test_multiple_expressions_failure
    error_message = <<~FAILURE
      \"@items.count\" didn't change by 1
      \"@items.select(&:nil?).count\" didn't change by 1
    FAILURE
    assert_failure_with_message(error_message) do
      assert_difference(['@items.count', '@items.select(&:nil?).count']) { }
    end
  end

  def test_hash_expressions_success
    assert_difference(@items => 1, '@items.count' => 1) do
      @items << 1
    end
  end

  def test_hash_expressions_failure
    error_message = <<~FAILURE
      \"@items.count\" didn't change by 3
    FAILURE
    assert_failure_with_message(error_message) do
      assert_difference('@items.count' => 3) { }
    end
  end
end
