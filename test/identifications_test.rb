require_relative "test_helper"

class TestIdentifications < Test::Unit::TestCase
  def setup
    @per_page = 10
  end

  def test_identifications_id
    VCR.use_cassette("test_identifications_id") do
      res = Nasturtium.identifications(id: 342040114, per_page: @per_page)
      assert_equal(342040114, res['results'][0]['id'])
    end
  end

  def test_identifications_current_taxon
    VCR.use_cassette("test_identifications_current_taxon") do
      res = Nasturtium.identifications(current_taxon: true, per_page: @per_page)
      res['results'].each do |r|
        assert_equal(r['taxon']['id'], r['observation']['taxon']['id'])
      end
    end
  end

  def test_identifications_current_taxon_false
    VCR.use_cassette("test_identifications_current_taxon_false") do
      res = Nasturtium.identifications(current_taxon: false, per_page: @per_page)
      res['results'].each do |r|
        assert_not_equal(r['taxon']['id'], r['observation']['taxon']['id'])
      end
    end
  end

  def test_identifications_own_observation
    VCR.use_cassette("test_identifications_own_observation") do
      res = Nasturtium.identifications(own_observation: true, per_page: @per_page)
      res['results'].each do |r|
        assert_equal(r['user']['id'], r['observation']['user']['id'])
      end
    end
  end

  def test_identifications_own_observation_false
    VCR.use_cassette("test_identifications_own_observation_false") do
      res = Nasturtium.identifications(own_observation: false, per_page: @per_page)
      res['results'].each do |r|
        assert_not_equal(r['user']['id'], r['observation']['user']['id'])
      end
    end
  end

  def test_identifications_is_change
    VCR.use_cassette("test_identifications_is_change") do
      res = Nasturtium.identifications(is_change: true, per_page: @per_page)
      res['results'].each do |r|
        assert_not_nil(r['taxon_change'])
      end
    end
  end

  def test_identifications_is_change_false
    VCR.use_cassette("test_identifications_is_change_false") do
      res = Nasturtium.identifications(is_change: false, per_page: @per_page)
      res['results'].each do |r|
        assert_nil(r['taxon_change'])
      end
    end
  end

  def test_identifications_taxon_active
    VCR.use_cassette("test_identifications_taxon_active") do
      res = Nasturtium.identifications(taxon_active: true, per_page: @per_page)
      res['results'].each do |r|
        assert_true(r['taxon']['is_active'])
      end
    end
  end

  def test_identifications_taxon_active_false
    VCR.use_cassette("test_identifications_taxon_active_false") do
      res = Nasturtium.identifications(taxon_active: false, per_page: @per_page)
      res['results'].each do |r|
        assert_false(r['taxon']['is_active'])
      end
    end
  end

  def test_identifications_obs_taxon_active
    VCR.use_cassette("test_identifications_obs_taxon_active") do
      res = Nasturtium.identifications(observation_taxon_active: true, per_page: @per_page)
      res['results'].each do |r|
        assert_true(r['observation']['taxon']['is_active'])
      end
    end
  end

  # TODO: iNaturalist bug? Some return true
  # def test_identifications_obs_taxon_active_false
  #   VCR.use_cassette("test_identifications_obs_taxon_active_false") do
  #     res = Nasturtium.identifications(observation_taxon_active: false, per_page: @per_page)
  #     res['results'].each do |r|
  #       assert_false(r['observation']['taxon']['is_active'])
  #     end
  #   end
  # end

  def test_identifications_rank
    VCR.use_cassette("test_identifications_rank") do
      res = Nasturtium.identifications(rank: 'variety', per_page: @per_page)
      res['results'].each do |r|
        assert_equal('variety', r['taxon']['rank'])
      end
    end
  end

  def test_identifications_obs_rank
    VCR.use_cassette("test_identifications_obs_rank") do
      res = Nasturtium.identifications(rank: 'species', observation_rank: 'variety', per_page: @per_page)
      res['results'].each do |r|
        assert_equal('variety', r['observation']['taxon']['rank'])
      end
    end
  end

  def test_identifications_user_id
    VCR.use_cassette("test_identifications_user_id") do
      res = Nasturtium.identifications(user_id: '20717', per_page: @per_page)
      res['results'].each do |r|
        assert_equal(20717, r['user']['id'])
      end
    end
  end

  def test_identifications_current
    VCR.use_cassette("test_identifications_current") do
      res = Nasturtium.identifications(current: true, per_page: @per_page)
      res['results'].each do |r|
        assert_true(r['current'])
      end
    end
  end

  def test_identifications_current_false
    VCR.use_cassette("test_identifications_current_false") do
      res = Nasturtium.identifications(current: false, per_page: @per_page)
      res['results'].each do |r|
        assert_false(r['current'])
      end
    end
  end

  def test_identifications_category
    VCR.use_cassette("test_identifications_category") do
      res = Nasturtium.identifications(category: 'leading', per_page: @per_page)
      res['results'].each do |r|
        assert_equal('leading', r['category'])
      end
    end
  end

  def test_identifications_place_id
    VCR.use_cassette("test_identifications_place_id") do
      res = Nasturtium.identifications(place_id: 35, per_page: @per_page)
      res['results'].each do |r|
        assert_include(r['observation']['place_ids'], 35)
      end
    end
  end

  # TODO: iNaturalist bug? quality_grade='research,casual' results include needs_id
  def test_identifications_quality_grade
    VCR.use_cassette("test_identifications_quality_grade") do
      res = Nasturtium.identifications(quality_grade: 'research', per_page: @per_page)
      res['results'].each do |r|
        assert_equal('research', r['observation']['quality_grade'])
      end
    end
  end

  # TODO: iNaturalist documentation seems wrong? "ID taxa must match the given taxa or their descendants"
  def test_identifications_taxon_id
    VCR.use_cassette("test_identifications_taxon_id") do
      res = Nasturtium.identifications(taxon_id: 42196, per_page: @per_page)
      res['results'].each do |r|
        assert_include(r['taxon']['ancestor_ids'], 42196)
      end
    end
  end

  # TODO: iNaturalist documentation seems wrong? "ID taxa must match the given taxa or their descendants"
  def test_identifications_obs_taxon_id
    VCR.use_cassette("test_identifications_obs_taxon_id") do
      res = Nasturtium.identifications(observation_taxon_id: 42196, per_page: @per_page)
      res['results'].each do |r|
        assert_include(r['observation']['taxon']['ancestor_ids'], 42196)
      end
    end
  end

  def test_identifications_iconic_taxon_id
    VCR.use_cassette("test_identifications_iconic_taxon_id") do
      res = Nasturtium.identifications(iconic_taxon_id: 40151, per_page: @per_page)
      res['results'].each do |r|
        assert_equal(40151, r['taxon']['iconic_taxon_id'])
      end
    end
  end

  def test_identifications_obs_iconic_taxon_id
    VCR.use_cassette("test_identifications_obs_iconic_taxon_id") do
      res = Nasturtium.identifications(observation_taxon_id: 40151, per_page: @per_page)
      res['results'].each do |r|
        assert_equal(40151, r['observation']['taxon']['iconic_taxon_id'])
      end
    end
  end

  def test_identifications_taxon_rank_highest
    VCR.use_cassette("test_identifications_taxon_rank_highest") do
      res = Nasturtium.identifications(rank_highest: 'genus', per_page: @per_page)
      res['results'].each do |r|
        assert_include(%w[genus section species subspecies variety], r['taxon']['rank'])
      end
    end
  end

  def test_identifications_taxon_rank_lowest
    VCR.use_cassette("test_identifications_taxon_rank_lowest") do
      res = Nasturtium.identifications(rank_lowest: 'phylum', per_page: @per_page)
      res['results'].each do |r|
        assert_include(%w[stateofmatter kingdom phylum], r['taxon']['rank'])
      end
    end
  end

  def test_identifications_taxon_obs_rank_highest
    VCR.use_cassette("test_identifications_taxon_obs_rank_highest") do
      res = Nasturtium.identifications(observation_rank_highest: 'genus', per_page: @per_page)
      res['results'].each do |r|
        assert_include(%w[genus section species subspecies variety], r['observation']['taxon']['rank'])
      end
    end
  end

  def test_identifications_taxon_obs_rank_lowest
    VCR.use_cassette("test_identifications_taxon_obs_rank_lowest") do
      res = Nasturtium.identifications(observation_rank_lowest: 'phylum', per_page: @per_page)
      res['results'].each do |r|
        assert_include(%w[stateofmatter kingdom phylum], r['observation']['taxon']['rank'])
      end
    end
  end

  def test_identifications_without_taxon_id
    VCR.use_cassette("test_identifications_without_taxon_id") do
      res = Nasturtium.identifications(taxon_id: 174047, without_taxon_id: 454805, per_page: @per_page)
      res['results'].each do |r|
        assert_not_equal(454805, r['taxon']['id'])
      end
    end
  end

  def test_identifications_without_obs_taxon_id
    VCR.use_cassette("test_identifications_without_obs_taxon_id") do
      res = Nasturtium.identifications(taxon_id: 174047, without_observation_taxon_id: 454805, per_page: @per_page)
      res['results'].each do |r|
        assert_not_equal(454805, r['observation']['taxon']['id'])
      end
    end
  end

  def test_identifications_created
    VCR.use_cassette("test_identifications_created") do
      res = Nasturtium.identifications(after: '2020-01-01', before: '2020-01-03', per_page: @per_page)
      res['results'].each do |r|
        assert_include(%w[2020-01-01 2020-01-02 2020-01-03], r['created_at_details']['date'])
      end
    end
  end

  def test_identifications_obs_created
    VCR.use_cassette("test_identifications_obs_created") do
      res = Nasturtium.identifications(observation_created_after: '2020-01-01', observation_created_before: '2020-01-03', per_page: @per_page)
      res['results'].each do |r|
        assert_include(%w[2020-01-01 2020-01-02 2020-01-03], r['observation']['created_at_details']['date'])
      end
    end
  end

  def test_identifications_obs_time
    VCR.use_cassette("test_identifications_obs_time") do
      res = Nasturtium.identifications(observed_after: '2020-01-01', observed_before: '2020-01-03', per_page: @per_page)
      res['results'].each do |r|
        assert_include(%w[2020-01-01 2020-01-02 2020-01-03], r['observation']['observed_on_details']['date'])
      end
    end
  end

  def test_identifications_id_range
    VCR.use_cassette("test_identifications_id_range") do
      res = Nasturtium.identifications(id_above: 10000, id_below: 11000, per_page: @per_page)
      res['results'].each do |r|
        in_range = (r['id'] < 11000 and r['id'] > 10000)
        assert_true(in_range)
      end
    end
  end

  def test_identifications_pagination_offset
    VCR.use_cassette("test_identifications_pagination") do
      res = Nasturtium.identifications(page: 5, per_page: 1)
      assert_equal(5, res['page'])
    end
  end

  def test_identifications_pagination_limit
    VCR.use_cassette("test_identifications_pagination") do
      res = Nasturtium.identifications(page: 5, per_page: 1)
      assert_equal(1, res['per_page'])
    end
  end

  def test_identifications_ordering
    VCR.use_cassette("test_identifications_ordering") do
      res = Nasturtium.identifications(order: 'asc', order_by: 'id', per_page: @per_page)
      prev = 0
      res['results'].each do |r|
        assert_true(r['id'] > prev)
      end
    end
  end

  def test_identifications_only_id
    VCR.use_cassette("test_identifications_only_id") do
      res = Nasturtium.taxa(only_id: true, per_page: @per_page)
      res['results'].each do |r|
        assert_not_includes(r, 'taxon')
      end
    end
  end
end