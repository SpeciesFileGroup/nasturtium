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

  def test_projects_not_id
    VCR.use_cassette("test_projects_not_id") do
      res = Nasturtium.projects(not_id: 15736, latitude: 41.295233, longitude: -89.024618, radius: 1, per_page: @per_page)
      matched = false
      res['results'].each do |r|
        if r['title'] == 'Matthiessen State Park'
            matched = true
        end
      end
      assert_false(matched)
    end
  end

  def test_projects_place_id
    VCR.use_cassette("test_projects_place_id") do
      res = Nasturtium.projects(place_id: 35, per_page: @per_page)
      res['results'].each do |r|
        unless r['place_id'].nil?
          place = Nasturtium.places_id(r['place_id'])
          assert_include(place['results'][0]['ancestor_place_ids'], 35)
        end
      end
    end
  end

  def test_projects_featured
    VCR.use_cassette("test_projects_featured") do
      res = Nasturtium.projects(featured: true, site_id: 1, per_page: @per_page)
      assert_true(res['total_results'] < 100)
    end
  end

  def test_projects_noteworthy
    VCR.use_cassette("test_projects_noteworthy") do
      res = Nasturtium.projects(noteworthy: true, site_id: 1, per_page: @per_page)
      assert_true(res['total_results'] < 100)
    end
  end

  def test_projects_type
    VCR.use_cassette("test_projects_type") do
      res = Nasturtium.projects(type: 'umbrella', per_page: @per_page)
      res['results'].each do |r|
        assert_equal(r['project_type'], 'umbrella')
        assert_true(r['is_umbrella'])
      end
    end
  end

  def test_projects_rule_details
    VCR.use_cassette("test_projects_rule_details") do
      res = Nasturtium.projects(rule_details: true, q: 'aves', per_page: @per_page)
      res['results'].each do |r|
        passed = false
        unless r['project_observation_rules'].size == 0
          r['project_observation_rules'].each do |rule|
            unless rule['taxon'].nil?
              passed = true
            end
          end
          assert_true(passed)
        end
      end
    end
  end

  def test_projects_member_id
    VCR.use_cassette("test_projects_member_id") do
      res = Nasturtium.projects(member_id: 20717, per_page: @per_page)
      res['results'].each do |r|
        assert_include(r['user_ids'], 20717)
      end
    end
  end

  def test_projects_has_params_true
    VCR.use_cassette("test_projects_has_params_true") do
      res = Nasturtium.projects(has_params: true, per_page: @per_page)
      res['results'].each do |r|
        assert_true(r['search_parameters'].size > 0)
      end
    end
  end

  def test_projects_has_params_false
    VCR.use_cassette("test_projects_has_params_false") do
      res = Nasturtium.projects(has_params: false, per_page: @per_page)
      res['results'].each do |r|
        assert_true(r['search_parameters'].size == 0)
      end
    end
  end

  def test_projects_has_posts_true
    VCR.use_cassette("test_projects_has_posts_true") do
      res = Nasturtium.projects(has_posts: true, per_page: @per_page)
      res['results'].each do |r|
        posts = Nasturtium.posts(project_id: r['id'])
        assert_true(posts.size > 0)
      end
    end
  end

  def test_projects_has_posts_false
    VCR.use_cassette("test_projects_has_posts_false") do
      res = Nasturtium.projects(has_posts: false, per_page: @per_page)
      res['results'].each do |r|
        posts = Nasturtium.posts(project_id: r['id'])
        assert_true(posts.size == 0)
      end
    end
  end

  def test_projects_members
    VCR.use_cassette("test_projects_members") do
      res = Nasturtium.project_members(733, page: 1, per_page: @per_page)
      res['results'].each do |r|
        assert_include(r, 'user')
      end
    end
  end

end