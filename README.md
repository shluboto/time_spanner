time_spanner
============

Returns a time span splitted in desired units given two timestamps.

[![Gem Version](https://badge.fury.io/rb/time_spanner.png)](http://badge.fury.io/rb/time_spanner) [![Code Climate](https://codeclimate.com/github/shlub/time_spanner.png)](https://codeclimate.com/github/shlub/time_spanner)

## Installation

Add this line to your application's Gemfile:

    gem 'time_spanner'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install time_spanner

## Usage

```ruby
 TimeSpan.new Time.parse('2012-04-05 07:05:05'), Time.parse('3024-11-14 12:06:49')
```
returns:

```ruby
 {:millenniums=>1, :centuries=>0, :decades=>1, :years=>2, :months=>7, :weeks=>1, :days=>2, :hours=>6, :minutes=>1, :seconds=>44, :milliseconds=>0, :microseconds=>0, :nanoseconds=>0}
```

## Specifying units

Define which time units should be calculated.
Pass them within an Array as a third parameter.

Available units are:
<pre>:millenniums, :centuries, :decades, :years, :months, :weeks, :days, :hours, :minutes, :seconds, :milliseconds, :microseconds, :nanoseconds</pre>

If no units are supplied it defaults to all units.


### Example

```ruby
 TimeSpan.new Time.parse('2012-04-05 07:05:05'), Time.at(Time.parse(2012-04-05 07:10:12', 1243.345), [:seconds, :milliseconds, :microseconds, :nanoseconds])
```
returns:

```ruby
 {:seconds=>307, :milliseconds=>1, :microseconds=>243, :nanoseconds=>345}
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
