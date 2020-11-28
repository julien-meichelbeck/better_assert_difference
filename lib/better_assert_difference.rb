require 'better_assert_difference/version'
require 'better_assert_difference/exceptions/difference_exception'

module BetterAssertDifference
  DEFAULT_DIFF = 1
  ACTIVE_RECORD_ENABLED = !!defined?(ActiveRecord)

  def assert_difference(expression, difference = DEFAULT_DIFF, message = nil, &block)
    expressions = active_record?(expression) ? [expression] : expression
    expression_to_diff =
      if expressions.is_a?(Hash)
        expressions
      else
        Array(expressions).each_with_object({}) { |exp, expression_hash| expression_hash[exp] = difference }
      end

    block_to_diff =
      expression_to_diff.each_with_object({}) do |(exp, diff), expression_hash|
        raise DifferenceException.new(diff) unless diff.is_a?(Integer)
        key =
          if exp.respond_to?(:call)
            exp
          elsif ACTIVE_RECORD_ENABLED && active_record?(exp)
            -> { exp.all.reset.count }
          else
            -> { eval(exp, block.binding) }
          end
        expression_hash[key] = diff
      end
    before = block_to_diff.keys.map(&:call)
    retval = yield
    after = block_to_diff.keys.map(&:call)

    errors = []
    before.zip(after, expression_to_diff) do |before_value, after_value, (exp, diff)|
      begin
        BetterAssertDifference::TestFramework.assert_equal(self, before_value + diff, after_value)
      rescue BetterAssertDifference::TestFramework.exception_kind
        error = "[#{expression_to_diff.find_index { |expression, _| expression == exp }}] " if expression_to_diff.size > 1
        name =
          if exp.is_a?(Class)
            exp.name
          elsif exp.class.name === 'ActiveRecord::Relation'
            exp.class.to_s
          else
            exp.inspect
          end
        error  = "#{error}#{name} didn't change by #{diff} {before: #{before_value}, after: #{after_value}}"
        error  = "#{message}.\n#{error}" if message
        errors << error
      end
    end

    if errors.any?
      errors.unshift "#{errors.size} assertion#{errors.length > 1 ? 's' : ''} failed:"
      BetterAssertDifference::TestFramework.notify_failure(errors)
    end

    retval
  end

  private

  def active_record?(expression)
    expression.respond_to?(:ancestors) &&
      expression.ancestors.map(&:to_s).include?('ActiveRecord::Base')
  end
end
