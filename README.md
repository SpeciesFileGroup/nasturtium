# Nasturtium

This is a Ruby wrapper on the [iNaturalist](https://api.inaturalist.org/v1/docs/#!/Search/get_search) API. Code follow the spirit/approach of the Gem [serrano](https://github.com/sckott/serrano), and indeed much of the wrapping utility is copied 1:1 from that repo, thanks [@sckott](https://github.com/sckott).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nasturtium'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install nasturtium

## Usage

---
### Search
Search places, projects, taxa, or users:
```ruby
Nasturtium.search(q: 'Quercus', sources: 'taxa') #  => MultiJson object
```
---

---
### Taxa
Search and fetch taxa with a comma-separted list of IDs:
```ruby
Nasturtium.taxa(id: '1,2') #  => MultiJson object
```
Search and fetch taxa:
```ruby
Nasturtium.taxa(q: 'Danaus plexippus', rank: 'species') #  => MultiJson object
```
Fetch taxa ordered by greatest observations count:
```ruby
Nasturtium.taxa(rank: 'species', order: 'desc', order_by: 'observations_count') #  => MultiJson object
```
---

---
### Taxa autocomplete
Get suggested taxa names for a query Sinapis at ranks genus,species,subspecies with a limit of 5 suggestions:
```ruby
Nasturtium.taxa_autocomplete(q: 'Sinapis', rank: 'genus,species,subspecies', per_page: 5) #  => MultiJson object
```
Include all names for each suggested taxon:
```ruby
Nasturtium.taxa_autocomplete(q: 'Sinapis', rank: 'genus,species,subspecies', per_page: 5, all_names: true) #  => MultiJson object
```
Get common names by the language at preferred_place_id which adds a preferred_common_name key (use Nasturtium.places_autocomplete to lookup place_id's):
```ruby
Nasturtium.taxa_autocomplete(q: 'Danaus plexippus', preferred_place_id: 6903, rank: 'species') #  => MultiJson object
```
---


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/SpeciesFileGroup/nasturtium. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/SpeciesFileGroup/nasturtium/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [NCSA/Illinois](https://opensource.org/licenses/NCSA).

## Code of Conduct

Everyone interacting in the Nasturtium project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/SpeciesFileGroup/nasturtium/blob/main/CODE_OF_CONDUCT.md).
