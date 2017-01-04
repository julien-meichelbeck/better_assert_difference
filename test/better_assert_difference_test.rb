require 'test_helper'

class BetterAssertDifferenceTest < Minitest::Test
  include BetterAssertDifference

  def setup
    @items = []
  end

  def test_multiple_expressions_success
    assert_difference(['@items.count', -> { @items.count }]) { @items << 1 }
  end

  def test_multiple_expressions_success_with_diff
    error_message = <<~FAILURE
      2 assertions failed:
      [0] Fruit didn't change by 3 {before: 0, after: 1}
      [1] "@items.count" didn't change by 3 {before: 0, after: 0}
    FAILURE
    assert_failure_with_message(error_message) do
      assert_difference([Fruit, '@items.count'], 3) { Fruit.create }
    end
  end

  def test_implicit_count_on_active_record_relation
    assert_difference(Fruit, 1) { Fruit.create }
  end

  def test_error_message_on_active_record_relation
    error_message = <<~FAILURE
      1 assertion failed:
      Fruit didn't change by 3 {before: 0, after: 1}
    FAILURE
    assert_failure_with_message(error_message) do
      assert_difference(Fruit, 3) { Fruit.create }
    end
  end

  def test_single_expression_failure
    error_message = <<~FAILURE
      1 assertion failed:
      \"@items.count\" didn't change by 1 {before: 0, after: 0}
    FAILURE
    assert_failure_with_message(error_message) do
      assert_difference('@items.count') { }
    end
  end

  def test_multiple_expressions_failure
    error_message = <<~FAILURE
      2 assertions failed:
      [0] \"@items.count\" didn't change by 1 {before: 0, after: 0}
      [1] \"@items.select(&:nil?).count\" didn't change by 1 {before: 0, after: 0}
    FAILURE
    assert_failure_with_message(error_message) do
      assert_difference(['@items.count', '@items.select(&:nil?).count']) { }
    end
  end

  def test_hash_expressions_success
    assert_difference(-> { @items.count } => 1, '@items.count' => 1) { @items << 1 }
  end

  def test_hash_expressions_failure
    error_message = <<~FAILURE
      1 assertion failed:
      \"@items.count\" didn't change by 3 {before: 0, after: 0}
    FAILURE
    assert_failure_with_message(error_message) do
      assert_difference('@items.count' => 3) { }
    end
  end
end
