# ExtID

It can be valuable to internally use a serial integer as an ID without revealing that ID to the outside world. extid
uses AES-128 to convert to and from an external ID that cannot feasibly be decoded without the secret key.

This prevents outsiders from quantifying the usage of your application by observing the rate of increase of IDs as well
as provides protection against brute force crawling of all resources.

## Installation

Install the gem and add to the application's Gemfile by executing:

```
$ bundle add extid
```

If bundler is not being used to manage dependencies, install the gem by executing:

```
$ gem install extid
```

## Usage

```ruby
require 'extid'

prefix = "user"
key = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15].pack('C*')
type = ExtID::Type.new prefix, key
type.encode(1) # => "user_13189a6ae4ab07ae70a3aabd30be99de"
type.decode("user_13189a6ae4ab07ae70a3aabd30be99de") # => 1
```

## Other Implementations

* [Go](https://github.com/jackc/go-extid)
* [PostgreSQL](https://github.com/jackc/pg-extid)
