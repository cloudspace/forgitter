# Forgitter

Forgitter is a .gitignore generator. It uses the \*.gitignore files found at
https://github.com/github/gitignore to generate a combined .gitignore file
locally. The \*.gitignore files are distributed with this gem for convenience.

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

Where TYPE1, TYPE2, etc. are the types of files to ignore. You can see a
complete list of available types by running:

    forgitter -l

See `forgitter -h` for additional options.

## Contributing

This gem depends on the https://github.com/github/gitignore repository as a
submodule. After cloning this repository, run the following to retrieve the
\*.gitignore files which will be cloned into `data/`:

    git submodule init && git submodule update

1. Fork it ( http://github.com/cloudspace/forgitter/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
