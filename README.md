
# BetterAssertDifference
`assert_difference`, but better.

![](https://api.travis-ci.org/julien-meichelbeck/better_assert_difference.svg?branch=master)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'better_assert_difference'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install better_assert_difference

## Usage

Include BetterAssertDifference in your tests:

```ruby
  # For Rails
  require 'better_assert_difference/rails_support'
  ActiveSupport::TestCase.include BetterAssertDifference
  # For MiniTest
  require 'better_assert_difference/minitest_support'
  Minitest::Test.include BetterAssertDifference
  # For RSpec
  require 'better_assert_difference/rspec_support'
  RSpec.configure do |config|
    config.include BetterAssertDifference
  end
```

#### Backward compatible
You can use `assert_difference` just as usual with string expressions or procs:
```ruby
  assert_difference('Foo.bar.count', 3) do
    # block omitted
  end

  assert_difference(-> { Foo.bar.count }, 2) do
    # block omitted
  end

  assert_difference([Foo, Bar, Baz], 4) do
    # block omitted
  end
```

#### Implicit call of `count` on ActiveRecord relations
Most of the time you'll want to execute `count` on ActiveRecord::Relation objects, this call is now implicit and you won't have to use a string expression or a proc.
```ruby
  assert_difference(Foo, 3) do
    # block omitted
  end
  assert_difference(Foo.where(bar: true)) do
    # block omitted
  end
```

#### Multiple differences in one call
Specify an expected difference for each expression:
```ruby
  assert_difference(Foo.where(bar: true) => 3, Foo.where(baz: false) => 5) do
    # block omitted
  end
```

#### Better error message
assert_difference will list all the assertions that have failed, not just the first one.
```console
  2 assertions failed:
  [0] @items.select(&:nil?).count didn't change by 2 {before: 0, after: 1}
  [1] @items.count didn't change by 3 {before: 2, after: 5}
```
## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/julien-meichelbeck/better_assert_difference.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
