# frozen_string_literal: true
module BetterAssertDifference
  class DifferenceException < StandardError
    def initialize(difference)
      super(
        <<~ERROR
          \nDifference is a #{difference}, it must be an integer.
          If you want to assert the difference of multiple expressions wrap them in an array:
          assert_difference [Foo, Bar], 1 { }
        ERROR
      )
    end
  end
end
