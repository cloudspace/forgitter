# Forgitter

Forgitter is a .gitignore generator. It is based on the ignorefiles found at
https://github.com/github/gitignore.

## Installation

Add this line to your application's Gemfile:

    gem 'forgitter'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install forgitter

## Usage

To generate a .gitignore, run:

    forgitter TAG1 [TAG2 ...]

Where TAG1, TAG2, etc. are tags that correspond to .gitignore files, e.g.,

>     $ forgitter vim
>     # github/Global/vim.gitignore
>     [._]*.s[a-w][a-z]
>     [._]s[a-w][a-z]
>     *.un~
>     Session.vim
>     .netrwhist
>     *~

By default, this will output to the standard output stream. You can redirect
this to a file using one of the following:

    forgitter TAG1 [TAG2 ...] > .gitignore  # overwrite
    forgitter TAG1 [TAG2 ...] >> .gitignore # append

To see a list of ignorefiles that match specific tags, run:

    forgitter -l TAG1 [TAG2 ...]

>     $ forgitter -l rails
>     cloudspace rails chefcookbook	cloudspace/rails/ChefCookbook.gitignore
>     cloudspace rails linux       	cloudspace/rails/Linux.gitignore
>     cloudspace rails rails       	cloudspace/rails/Rails.gitignore
>     cloudspace rails ruby        	cloudspace/rails/Ruby.gitignore
>     github rails                 	github/Rails.gitignore

Running `forgitter -l` without arguments will list all available
ignorefiles.

## Contributing

This gem depends on the https://github.com/github/gitignore repository as a
submodule. After cloning this repository, run the following to retrieve the
\*.gitignore files which will be cloned into `data/`:

    git submodule init && git submodule update

\*.gitignore files placed directly under `data/` will be ignored due to tag
ambiguity.

1. Fork it ( http://github.com/cloudspace/forgitter/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
