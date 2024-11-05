# Nasturtium

![Nasturtium Logo](https://github.com/SpeciesFileGroup/nasturtium/assets/8573609/7a19d255-a62e-429d-9fa0-43711ad60f2c)

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

### Controlled vocabulary terms

Get controlled vocabulary terms
```ruby
Nasturtium.controlled_terms #  => MultiJson object
```

Get controlled vocabulary terms for a taxon
```ruby
Nasturtium.controlled_terms(taxon_id: 1) #  => MultiJson object
```

### Identifications
These are just some examples. For a complete list [view the tests](https://github.com/SpeciesFileGroup/nasturtium/blob/main/test/identifications_test.rb) for examples or the [API documentation](https://api.inaturalist.org/v1/docs/#!/Identifications/get_identifications).

Get an identification by ID
```ruby
Nasturtium.identifications(id: 342040114) #  => MultiJson object
```

Get identifications in which the taxon is the same as the observation's taxon
```ruby
Nasturtium.identifications(current_taxon: true) #  => MultiJson object
```

Get identifications which were added by the observer
```ruby
Nasturtium.identifications(own_observation: true) #  => MultiJson object
```

Get identifications by taxonomic rank
```ruby
Nasturtium.identifications(rank: 'suborder') #  => MultiJson object
```

Get identifications with the rank species and the observation rank variety:
```ruby
Nasturtium.identifications(rank: 'species', observation_rank: 'variety') #  => MultiJson object
```

Get identifications by a user_id:
```ruby
Nasturtium.identifications(user_id: '20717') #  => MultiJson object
```

Get identifications by category:
```ruby
Nasturtium.identifications(category: 'improving') #  => MultiJson object
```

Get identifications by quality grade:
```ruby
Nasturtium.identifications(quality_grade: 'research') #  => MultiJson object
```

Get identifications by taxon_id:
```ruby
Nasturtium.identifications(taxon_id: 42196) #  => MultiJson object
```

---
### Mapping
Get a grid map tile for the turkey vulture at zoom level 2 for coordinates (0, 1):
```ruby
Nasturtium.mapping('grid', 2, 0, 1, style: 'geotilegrid', tile_size: 512, taxon_id: 4756)
```

Get a colored_heatmap map tile for the turkey vulture at zoom level 2 for coordinates (0, 1):
```ruby
Nasturtium.mapping('colored_heatmap', 2, 0, 1, tile_size: 512, taxon_id: 4756, color: '#00ff00')
```

Get a points map tile for the turkey vulture at zoom level 2 for coordinates (0, 0):
```ruby
Nasturtium.mapping('points', 2, 0, 0, tile_size: 512, taxon_id: 4756, color: '#00ff00')
```

Get a points map tile for the turkey vulture at zoom level 2 for coordinates (0, 0):
```ruby
Nasturtium.mapping('grid', 2, 0, 1, taxon_id: 4756, return_json: true)
```

Get the taxon_places map for turkey vultures:
```ruby
Nasturtium.mapping('taxon_places', 2, 0, 1, taxon_id: 4756)
```

Get the taxon_ranges map for turkey vultures:
```ruby
Nasturtium.mapping('taxon_ranges', 2, 0, 1, taxon_id: 4756)
```

Get the places map for turkey vultures in place 35:
```ruby
Nasturtium.mapping('places', 2, 0, 0, place_id: 35, taxon_id: 4756, tile_size: 512)
```


---
### Observations
These are just some examples. For a complete list [view the tests](https://github.com/SpeciesFileGroup/nasturtium/blob/main/test/observations_test.rb) for examples or the [API documentation](https://api.inaturalist.org/v1/docs/#!/Observations/get_observations).

Get an observation by ID
```ruby
Nasturtium.observations(id: '150842485') #  => MultiJson object
```

Get observations with positional accuracy/coordinate uncertainty specified
```ruby
Nasturtium.observations(acc: true) #  => MultiJson object
```

Get captive/cultivated observations
```ruby
Nasturtium.observations(captive: true) #  => MultiJson object
```

Exclude captive/cultivated observations
```ruby
Nasturtium.observations(captive: false) #  => MultiJson object
```

Get observations in which the taxon is endemic to their location
```ruby
Nasturtium.observations(endemic: true) #  => MultiJson object
```

Get observations that are georeferenced
```ruby
Nasturtium.observations(geo: true) #  => MultiJson object
```

Get observations that have been identified
```ruby
Nasturtium.observations(identified: true) #  => MultiJson object
```

Get observations in which the taxon has been introduced in their location
```ruby
Nasturtium.observations(introduced: true) #  => MultiJson object
```

Get observations that show on map tiles
```ruby
Nasturtium.observations(mappable: true) #  => MultiJson object
```

Get observations in which the taxon is native in their location
```ruby
Nasturtium.observations(native: true) #  => MultiJson object
```

Get observations in which the taxon was observed outside of their known range
```ruby
Nasturtium.observations(out_of_range: true) #  => MultiJson object
```

Get observations with photos
```ruby
Nasturtium.observations(photos: true) #  => MultiJson object
```

Get observations that have been favorited by at least 1 user
```ruby
Nasturtium.observations(popular: true) #  => MultiJson object
```

Get observations with sounds
```ruby
Nasturtium.observations(sounds: true) #  => MultiJson object
```

Get observations in which the taxon concept is active
```ruby
Nasturtium.observations(taxon_is_active: true) #  => MultiJson object
```

Get observations in which the taxon is threatened in their location
```ruby
Nasturtium.observations(threatened: true) #  => MultiJson object
```

Get observations with a quality_grade of needs_id or research
```ruby
Nasturtium.observations(verifiable: true) #  => MultiJson object
```

Get observations that have a cc0 license
```ruby
Nasturtium.observations(license: 'cc0') #  => MultiJson object
```

Get observations that have a license
```ruby
Nasturtium.observations(licensed: true) #  => MultiJson object
```

Get observations that have a cc0 photo license
```ruby
Nasturtium.observations(photo_license: 'cc0') #  => MultiJson object
```

Get observations in which at least 1 photo has a license
```ruby
Nasturtium.observations(photo_licensed: true) #  => MultiJson object
```

Get observations by a place_id
```ruby
Nasturtium.observations(place_id: 26) #  => MultiJson object
```

Get observations from a project_id
```ruby
Nasturtium.observations(project_id: 22499) #  => MultiJson object
```

Get observations by a taxonomic rank
```ruby
Nasturtium.observations(rank: 'subspecies') #  => MultiJson object
```

Get observations by an iNaturalist network website site_id
```ruby
Nasturtium.observations(site_id: 2) #  => MultiJson object
```

Get observations with a cc0 licensed sound recording
```ruby
Nasturtium.observations(sound_license: 'cc0') #  => MultiJson object
```

Get observations by a taxon_id
```ruby
Nasturtium.observations(taxon_id: '522193') #  => MultiJson object
```

Get observations by a taxon_name
```ruby
Nasturtium.observations(taxon_name: 'Nasturtium floridanum') #  => MultiJson object
```

Get observations by a user_id
```ruby
Nasturtium.observations(user_id: '20717') #  => MultiJson object
```

Get observations by a user_login
```ruby
Nasturtium.observations(user_login: 'debpaul') #  => MultiJson object
```

Get observations by a date
```ruby
Nasturtium.observations(year: 2020, month: 3, day: 15) #  => MultiJson object
```

Get observations that have a controlled vocabulary term
```ruby
Nasturtium.observations(term_id: 1) #  => MultiJson object
```

Get observations that have controlled vocabulary term 1 and controlled vocabulary value 2
```ruby
Nasturtium.observations(term_id: 1, term_value_id: 2)
```

Get observations with positional accuracy above 100 meters and below 200 meters
```ruby
Nasturtium.observations(acc_above: 100, acc_below: 200)
```

Get observations with open geoprivacy
```ruby
Nasturtium.observations(geoprivacy: 'open')
```

Get observations with a taxonomic rank above genus and below phylum
```ruby
Nasturtium.observations(rank_highest: 'genus', rank_lowest: 'phylum')
```

Get observations in which most people agree on the identification
```ruby
Nasturtium.observations(identifications: 'most_agree')
```

Get observations with research quality grade identifications
```ruby
Nasturtium.observations(quality_grade: 'research')
```

Get observations within a 1 km radius of 45.703259, -85.552406
```ruby
@ne_lat = 40.084300
@sw_lat = 40.075877
@ne_lng = -88.198636
@sw_lng = -88.210169
Nasturtium.observations(latitude: 45.703259, longitude: -85.552406, radius: 1)
```

Get observations within a bounding box
```ruby
@ne_lat = 40.084300
@sw_lat = 40.075877
@ne_lng = -88.198636
@sw_lng = -88.210169
Nasturtium.observations(ne_latitude: @ne_lat, ne_longitude: @ne_lng, sw_longitude: @sw_lat, sw_latitude: @sw_lng)
```

Search for observations with the query Parastratiosphecomyia
```ruby
Nasturtium.observations(q: 'Parastratiosphecomyia')
```

Search for observations with Meadowbrook in a place name
```ruby
Nasturtium.observations(q: 'Meadowbrook', search_on: 'place')
```

Search for observations with blue in a tag name
```ruby
Nasturtium.observations(q: 'blue', search_on: 'tags')
```

Search for observations with blue in the description
```ruby
Nasturtium.observations(q: 'blue', search_on: 'description')
```

Search for observations with grizzly in the names
```ruby
Nasturtium.observations(q: 'grizzly', search_on: 'names')
```

---
### Places
Get places by ID with an admin_level of 100
```ruby
Nasturtium.places_id(1000, admin_level: 100) #  => MultiJson object
```

---
### Places autocomplete
Get suggested place name autocompletions
```ruby
Nasturtium.places_autocomplete('Kickapoo Rail Trail') #  => MultiJson object
```

---
### Places nearby
Get place names nearby within a bounding box and that include the string Meadowbrook
```ruby
@ne_lat = 40.084300
@sw_lat = 40.075877
@ne_lng = -88.198636
@sw_lng = -88.210169
Nasturtium.places_nearby(@ne_lat, @ne_lng, @sw_lat, @sw_lng, name: "Meadowbrook") #  => MultiJson object
```

---
### Posts
Get journal posts:
```ruby
Nasturtium.posts #  => MultiJson object
```

Get journal posts for parent_id:
```ruby
Nasturtium.posts(parent_id: 1, page: 1, per_page: 10) #  => MultiJson object
```

Get journal posts for project_id:
```ruby
Nasturtium.posts(project_id: 42768) #  => MultiJson object
```

Get journal posts for a user:
```ruby
Nasturtium.posts(login: 'loarie') #  => MultiJson object
```

---
### Projects
Search projects with query term, Illinois:
```ruby
Nasturtium.projects(q: 'Illinois') #  => MultiJson object
```

Get a project by ID
```ruby
Nasturtium.projects(id: 22499) #  => MultiJson object
```

Search for projects within 5 km of 40.11136254505831, -88.2460817474295
```ruby
Nasturtium.projects(latitude: 40.11136254505831, longitude: -88.2460817474295, radius: 5) #  => MultiJson object
```

Get projects with place_id or with place_id as a place ancestor
```ruby
Nasturtium.projects(place_id: 35) #  => MultiJson object
```

Get featured projects on iNaturalist México
```ruby
Nasturtium.projects(featured: true, site_id: 2) #  => MultiJson object
```

Get noteworthy projects on iNaturalist
```ruby
Nasturtium.projects(noteworthy: true, site_id: 1) #  => MultiJson object
```

Get projects that include user_id as a member
```ruby
Nasturtium.projects(member_id: 477) #  => MultiJson object
```

Get projects with journal posts
```ruby
Nasturtium.projects(has_posts: true) #  => MultiJson object
```

---
### Project members
Get the members of project_id 733
```ruby
Nasturtium.project_members(733, page: 1, per_page: 10)
```

---
### Search
Search places, projects, taxa, or users:
```ruby
Nasturtium.search(q: 'Quercus', sources: 'taxa') #  => MultiJson object
```

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
### User
Get a user by ID
```ruby
Nasturtium.user(20717) #  => MultiJson object
```


---
### User autocomplete
Suggest a user by autocomplete
```ruby
Nasturtium.user_autocomplete('debpau') #  => MultiJson object
```


---
### User projects
Get a user's projects of type collection
```ruby
Nasturtium.user_projects(20717, project_type: 'collection') #  => MultiJson object
```
---


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/SpeciesFileGroup/nasturtium. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/SpeciesFileGroup/nasturtium/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT license](https://opensource.org/licenses/NCSA).

## Code of Conduct

Everyone interacting in the Nasturtium project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/SpeciesFileGroup/nasturtium/blob/main/CODE_OF_CONDUCT.md).
