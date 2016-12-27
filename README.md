[![Version     ](https://img.shields.io/gem/v/cloaca.svg?style=flat)](https://rubygems.org/gems/cloaca)
# Cloaca

Cloaca provides a library of transformations for CSV files and other row structured data.

It does this by providing command-line operations for manipulating a data stream. Operations can be concatenated to perform more complex file transformations.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cloaca'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cloaca


## Usage

```bash
exe/cloaca

Cloaca commands:
  cloaca add-fixed-value-column --col-value=column cell value                    # adds a fixed value column to a stream of data
  cloaca add-integer-index-column                                                # adds a index column to a stream of data
  cloaca add-numeric-index-column                                                # adds a index column to a stream of data
  cloaca change-col-delimiter --new-col-delim=column delimiter                   # change the column delimiter for a stream of data
  cloaca check-headers-unique                                                    # checks that each column has a unique header value
  cloaca extract-unique-col-values --index-or-value=column index or header       # extract unique vlaues for a column, one per line
  cloaca generate-int N                                                          # generates N random integers, one per line
  cloaca help [COMMAND]                                                          # Describe available commands or one specific command
  cloaca remove-col-quotes --index-or-value=column index or header               # removes quotes from a column's values
  cloaca remove-column (index or value) --index-or-value=column index or header  # removes the column
  cloaca remove-header-row                                                       # removes the first N rows (default N = 1)
```


## What's in a Name?

cloaca [kloh-ey-kuh]

Definitions:
1. maw of voracious person
2. privy (medieval)
3. sewer, underground drain


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mchadwick/cloaca. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
