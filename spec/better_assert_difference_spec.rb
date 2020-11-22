require 'spec_helper'

RSpec.describe BetterAssertDifference do
  before(:each) do
    @items = []
  end

  it 'test_multiple_expressions_success' do
    assert_difference(['@items.count', -> { @items.count }]) { @items << 1 }
  end

  it 'test_multiple_expressions_success_with_diff' do
    error_message = <<~FAILURE
      2 assertions failed:
      [0] Fruit didn't change by 3 {before: 0, after: 1}
      [1] "@items.count" didn't change by 3 {before: 0, after: 0}
    FAILURE
    assert_failure_with_message(error_message) do
      assert_difference([Fruit, '@items.count'], 3) { Fruit.create }
    end
  end

  it 'test_implicit_count_on_active_record_class' do
    assert_difference(Fruit, 1) { Fruit.create }
  end

  it 'test_implicit_count_on_active_record_relation' do
    assert_difference(Fruit.all, 1) { Fruit.create }
  end

  it 'test_error_message_on_active_record_relation' do
    error_message = <<~FAILURE
      1 assertion failed:
      Fruit didn't change by 3 {before: 0, after: 1}
    FAILURE
    assert_failure_with_message(error_message) do
      assert_difference(Fruit, 3) { Fruit.create }
    end
  end

  it 'test_single_expression_failure' do
    error_message = <<~FAILURE
      1 assertion failed:
      \"@items.count\" didn't change by 1 {before: 0, after: 0}
    FAILURE
    assert_failure_with_message(error_message) do
      assert_difference('@items.count') { }
    end
  end

  it 'test_multiple_expressions_failure' do
    error_message = <<~FAILURE
      2 assertions failed:
      [0] \"@items.count\" didn't change by 1 {before: 0, after: 0}
      [1] \"@items.select(&:nil?).count\" didn't change by 1 {before: 0, after: 0}
    FAILURE
    assert_failure_with_message(error_message) do
      assert_difference(['@items.count', '@items.select(&:nil?).count']) { }
    end
  end

  it 'test_hash_expressions_success' do
    assert_difference(-> { @items.count } => 1, '@items.count' => 1) { @items << 1 }
  end

  it 'test_hash_expressions_failure' do
    error_message = <<~FAILURE
      1 assertion failed:
      \"@items.count\" didn't change by 3 {before: 0, after: 0}
    FAILURE
    assert_failure_with_message(error_message) do
      assert_difference('@items.count' => 3) { }
    end
  end

  it 'test_bad_difference_format' do
    error_message = <<~FAILURE

      Difference is a Fruit, it must be an integer.
      If you want to assert the difference of multiple expressions wrap them in an array:
      assert_difference [Foo, Bar], 1 { }

    FAILURE
    assert_failure_with_message(error_message, BetterAssertDifference::DifferenceException) do
      assert_difference('@items.count', Fruit) { }
    end
  end

  it 'test_bad_difference_format_as_hash' do
    error_message = <<~FAILURE

      Difference is a Fruit, it must be an integer.
      If you want to assert the difference of multiple expressions wrap them in an array:
      assert_difference [Foo, Bar], 1 { }

    FAILURE
    assert_failure_with_message(error_message, BetterAssertDifference::DifferenceException) do
      assert_difference(Fruit => Fruit) { }
    end
  end
end
