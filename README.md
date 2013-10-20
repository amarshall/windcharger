# Windcharger

[![Build Status](https://secure.travis-ci.org/amarshall/windcharger.png?branch=master)](https://travis-ci.org/amarshall/windcharger)
[![Code Climate rating](https://codeclimate.com/github/amarshall/windcharger.png)](https://codeclimate.com/github/amarshall/windcharger)
[![Gem Version](https://badge.fury.io/rb/windcharger.png)](https://rubygems.org/gems/windcharger)

![Windcharger mascot. He carries powerful magnets in his arms that he can use to manipulate large objects.](https://i.imgur.com/lApzHFP.jpg "He carries powerful magnets in his arms that he can use to manipulate large objects.")

Windcharger is a small library to easily make objects that transform input via many methods.

## Installation

Install as usual: `gem install windcharger` or add `gem 'windcharger'` to your Gemfile.

## Usage

Declare methods as attributes by extending `Windcharger::Attributes` and preceding methods with `attribute`:

```ruby
require 'windcharger'

class MyTransformer
  extend Windcharger::Attributes

  attribute
  def foo; end

  attribute
  def bar; end

  def not_an_attribute; end
end

MyTransformer.attributes  #=> [:foo, :bar]
```

This isn’t very useful on its own, so include `Windcharger::HashTransformer` to get the `transform` method:

```ruby
require 'windcharger'

class MyTransformer
  extend Windcharger::Attributes
  include Windcharger::HashTransformer

  attribute
  def foo
    :the_foo
  end

  attribute
  def bar
    :walked_into_a_bar
  end

  def not_an_attribute
    42
  end
end

my_transformer = MyTransformer.new
my_transformer.transform #=> { :foo => :the_foo, :bar => :walked_into_a_bar }
```

Add an `initialize` that takes some input and then transform it to each attribute in their respective methods and you have a nice transformer object.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Credits & License

Copyright © 2013 J. Andrew Marshall. License is available in the LICENSE file.
