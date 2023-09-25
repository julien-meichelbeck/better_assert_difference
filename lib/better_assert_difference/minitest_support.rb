module BetterAssertDifference
  class MinitestSupport
    class << self
      def exception_kind
        Minitest::Assertion
      end

      def notify_failure(errors)
        raise Minitest::Assertion, errors.join("\n")
      end

      def assert_equal(context, computation, expectation)
        context.assert_equal(expectation, computation)
      end
    end
  end

  TestFramework = MinitestSupport
end
