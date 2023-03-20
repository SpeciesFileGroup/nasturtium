require_relative "test_helper"
require "byebug"

class TestPlaces < Test::Unit::TestCase
  def setup
    @per_page = 10
  end

  def test_places_id
    VCR.use_cassette("test_places_id") do
      res = Inaturalia.places_id(1000)
      assert_equal(1000, res['results'][0]['id'])
    end
  end

  def test_places_id_admin_level
    VCR.use_cassette("test_places_id_admin_level") do
      res = Inaturalia.places_id(1000, admin_level: 100)
      assert_equal(0, res['total_results'])
    end
  end

  def test_places_autocomplete
    VCR.use_cassette("test_places_autocomplete") do
      res = Inaturalia.places_autocomplete('Kickapoo Rail Trail')
      assert_equal('Kickapoo Rail Trail', res['results'][0]['name'])
    end
  end

  def test_places_autocomplete_the
    VCR.use_cassette("test_places_autocomplete_the") do
      res = Inaturalia.places_autocomplete('The')
      res['results'].each do |r|
        assert_include(r['name'], "The")
      end
    end
  end

  def test_places_nearby_bounding_coords_within
    VCR.use_cassette("test_places_nearby_bounding_coords_within") do
      @ne_lat = 40.084300
      @sw_lat = 40.075877
      @ne_lng = -88.198636
      @sw_lng = -88.210169
      res = Inaturalia.places_nearby(@ne_lat, @ne_lng, @sw_lat, @sw_lng)
      res['results']['community'].each do |r|
        r['geometry_geojson']['coordinates'].each do |a|
          a.each do |b|
            b.each do |c|
              within_bounds_lat = (c[1].to_f <= @ne_lat and c[1].to_f >= @sw_lat)
              within_bounds_lng = (c[0].to_f <= @ne_lng and c[0].to_f >= @sw_lng)
              assert_true(within_bounds_lat)
              assert_true(within_bounds_lng)
            end
          end
        end
      end
    end
  end

  # TODO: duplicate iNaturaist Meadowbrook and Meadow Brook communities?
  def test_places_nearby_name
    VCR.use_cassette("test_places_nearby_name") do
      @ne_lat = 40.084300
      @sw_lat = 40.075877
      @ne_lng = -88.198636
      @sw_lng = -88.210169
      res = Inaturalia.places_nearby(@ne_lat, @ne_lng, @sw_lat, @sw_lng, name: "Meadowbrook")
      res['results']['community'].each do |r|
        assert_include(r['display_name'], 'Meadowbrook')
      end
    end
  end
end