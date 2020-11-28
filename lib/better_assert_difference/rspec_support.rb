module BetterAssertDifference
  class RspecSupport
    class << self
      def exception_kind
        RSpec::Expectations::ExpectationNotMetError
      end

      def notify_failure(errors)
        RSpec::Expectations.fail_with(errors.join("\n"))
      end

      def assert_equal(context, computation, expectation)
        context.expect(computation).to context.eq(expectation)
      end
    end
  end

  TestFramework = RspecSupport
end
