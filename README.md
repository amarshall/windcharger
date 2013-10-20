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

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Credits & License

Copyright © 2013 J. Andrew Marshall. License is available in the LICENSE file.
