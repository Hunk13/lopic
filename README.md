# Lopic

[![Ruby](https://github.com/Hunk13/lopic/actions/workflows/ruby.yml/badge.svg?branch=master)](https://github.com/Hunk13/lopic/actions/workflows/ruby.yml)

List Of PICtures on website

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'lopic', github: 'hunk13/lopic'
```

And then execute:

    $ bundle

## Usage

```ruby
Lopic.get_images('https://yandex.ru')
```

will return Hash of all images on page

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hunk13/lopic. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

