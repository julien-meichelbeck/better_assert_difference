
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

```ruby
  Minitest::Test.include BetterAssertDifference
```

```ruby
  assert_difference([Foo.where(bar: true), 'Foo.where(bar: true).count', -> { Foo.where(bar: true).count }])
  assert_difference(Foo.where(bar: true))
  assert_difference(Foo.where(bar: true) => 2, Foo.where(bar: false) => 4)
```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/julien-meichelbeck/better_assert_difference.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
