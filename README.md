# LogfmtMarshalling

[![Build Status](https://travis-ci.org/MitinPavel/logfmt_marshalling.svg?branch=master)](https://travis-ci.org/MitinPavel/logfmt_marshalling)

A Ruby gem for emitting [logfmt logging format](https://brandur.org/logfmt).

logfmt (as a key-value logging format) is one flavor of [structured logging](http://gregoryszorc.com/blog/category/logging/).

## Installation

Add this line to your application's Gemfile:

    gem 'logfmt_marshalling'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install logfmt_marshalling

## Usage

```
> require 'logfmt_marshalling'
=> true
> LogfmtMarshalling.marshal method: 'get', path: '/', status: 200
=> "method=get path=/ status=200"
```

## Contributing

1. Fork it ( https://github.com/MitinPavel/logfmt_marshalling/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
