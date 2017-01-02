
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

Add in your `test_helper.rb`:
```ruby
  Minitest::Test.include BetterAssertDifference
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
```

#### Implicit call of `count` on ActiveRecord relations, arrays, etc.
Most of the time you'll want to `count` objects. You won't have to use string expressions or procs, just pass an `ActiveRecord_Relation` object or an array.
```ruby
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


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/julien-meichelbeck/better_assert_difference.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
