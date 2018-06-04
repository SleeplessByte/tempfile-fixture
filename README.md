# Tempfile::Fixture

Have tempfile serve you IO fixtures.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tempfile-fixture'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tempfile-fixture

## Usage

You can use the `Fixture` functionality anywhere. This is how you might use it:

```Ruby
# /test/test_helper.rb
 
require 'tempfile/fixture'  

def path_to_fixture(file) 
  File.expand_path(File.join('files', file), __dir__)
end
```
```Text
# /test/files/data.txt
42
11
99
23
12
```
```Ruby
# /test/my_fixture_test.rb

require_relative 'test_helper'

def test_calculate_sum
  Tempfile.Fixture(path_to_fixture('data.txt')) do |data_file|
    answer = calculate_sum(data_file.readlines)
    assert_equal 187, answer 
  end
end
```

Under the hood it's doing a `FileUtils` copy_file, so it will fail on directories (yay); you can pass `binary: true` to
force the tempfile to have a binary encoding. This probably doesn't do anything :'), because it's copying metadata as
well.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can 
also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the 
version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version,
push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/SleeplessByte/tempfile-fixture](https://github.com/SleeplessByte/tempfile-fixture).
