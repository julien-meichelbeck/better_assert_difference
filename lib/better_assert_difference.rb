require 'better_assert_difference/version'

module BetterAssertDifference
  DEFAULT_DIFF = 1
  ACTIVE_RECORD_ENABLED = !!defined?(ActiveRecord::Base)

  def assert_difference(expression, difference = DEFAULT_DIFF, message = nil, &block)
    expression_to_diff =
      if expression.is_a?(Hash)
        expression
      else
        Array(expression).each_with_object({}) { |exp, expression_hash| expression_hash[exp] = difference }
      end

    block_to_diff =
      expression_to_diff.each_with_object({}) do |(exp, diff), expression_hash|
        key =
          if exp.respond_to?(:call)
            exp
          elsif ACTIVE_RECORD_ENABLED && active_record?(exp)
            -> { exp.count }
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
      next if before_value + diff == after_value
      error = "[#{expression_to_diff.find_index { |expression, _| expression == exp }}] " if expression_to_diff.size > 1
      error  = "#{error}#{exp.inspect} didn't change by #{diff} {before: #{before_value}, after: #{after_value}}"
      error  = "#{message}.\n#{error}" if message
      errors << error
    end
    if errors.any?
      errors.unshift "#{errors.size} assertion#{errors.length > 1 ? 's' : ''} failed:"
      fail errors.join("\n")
    end

    retval
  end

  private

    def active_record?(expression)
      expression.respond_to?(:ancestors) &&
        expression.ancestors.map(&:to_s).include?('ActiveRecord::Base')
    end
end
