require_relative "test_helper"

class TestUser < Test::Unit::TestCase
  def setup
    @per_page = 10
  end

  def test_projects_id
    VCR.use_cassette("test_projects_id") do
      res = Nasturtium.projects(id: '67047', per_page: @per_page)
      assert_equal('champaign-county-forest-preserve-district', res['results'][0]['slug'])
    end
  end

  def test_projects_lat_long
    VCR.use_cassette("test_projects_lat_long") do
      res = Nasturtium.projects(latitude: 41.295233, longitude: -89.024618, radius: 1, per_page: @per_page)
      matched = false
      res['results'].each do |r|
        if r['title'] == 'Matthiessen State Park'
            matched = true
        end
      end
      assert_true(matched)
    end
  end

end