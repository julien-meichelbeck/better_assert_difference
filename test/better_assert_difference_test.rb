require 'test_helper'

class BetterAssertDifferenceTest < Minitest::Test
  include BetterAssertDifference

  def setup
    @items = []
  end

  def test_multiple_expressions
    assert_difference([@items, '@items.count', -> { @items.count }]) do
      @items << 1
    end
  end

  def test_hash_expressions
    assert_difference(@items => 1, '@items.count' => 1) do
      @items << 1
    end
  end
end
