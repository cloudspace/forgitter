# Forgitter

Forgitter is a .gitignore generator. It uses the *.gitignore files found at
https://github.com/github/gitignore to generate a combined .gitignore file
locally.

## Installation

Add this line to your application's Gemfile:

    gem 'forgitter'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install forgitter

## Usage

To generate a .gitignore in the current directory, run:

    forgitter TYPE1 [TYPE2 ...]

Where TYPE1, TYPE2, etc. are the keys found in the
[types](https://github.com/cloudspace/forgitter/blob/master/lib/forgitter/types.rb)
hash.

See `forgitter -h` for more options.

## Contributing

1. Fork it ( http://github.com/cloudspace/forgitter/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
