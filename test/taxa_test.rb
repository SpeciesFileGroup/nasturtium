require_relative "test_helper"

class TestTaxa < Test::Unit::TestCase

  def test_taxa_id
    VCR.use_cassette("test_taxa_id") do
      res = Nasturtium.taxa(id: 1)
      assert_equal('Animalia', res['results'][0]['name'])
    end
  end

  def test_taxa_parent_id
    VCR.use_cassette("test_taxa_parent_id") do
      res = Nasturtium.taxa(parent_id: 1)
      res['results'].each do |r|
        assert_equal(1, r['parent_id'])
      end
    end
  end

  def test_taxa_q
    VCR.use_cassette("test_taxa_q") do
      res = Nasturtium.taxa(q: 'oak')
      res['results'].each do |r|
        assert_includes(r['matched_term'].downcase, 'oak')
      end
    end
  end

  def test_taxa_active_true
    VCR.use_cassette("test_taxa_active") do
      res = Nasturtium.taxa(is_active: true)
      res['results'].each do |r|
        assert_true(r['is_active'])
      end
    end
  end

  def test_taxa_active_false
    VCR.use_cassette("test_taxa_active_false") do
      res = Nasturtium.taxa(is_active: false)
      res['results'].each do |r|
        assert_false(r['is_active'])
      end
    end
  end

  def test_taxa_rank
    VCR.use_cassette("test_taxa_rank") do
      res = Nasturtium.taxa(rank: 'kingdom')
      res['results'].each do |r|
        assert_equal('kingdom', r['rank'])
      end
    end
  end

  def test_taxa_rank_level
    VCR.use_cassette("test_taxa_rank_level") do
      res = Nasturtium.taxa(rank_level: 70)
      res['results'].each do |r|
        assert_equal('kingdom', r['rank'])
      end
    end
  end

  def test_taxa_id_above_below
    VCR.use_cassette("test_taxa_id_above_below") do
      res = Nasturtium.taxa(id_above: 20, id_below: 30)
      res['results'].each do |r|
        assert_true(r['id'] > 20)
        assert_true(r['id'] < 30)
      end
    end
  end

  def test_taxa_pagination_offset
    VCR.use_cassette("test_taxa_pagination") do
      res = Nasturtium.taxa(page: 3, per_page: 2)
      assert_equal(3, res['page'])
    end
  end

  def test_taxa_pagination_limit
    VCR.use_cassette("test_taxa_pagination") do
      res = Nasturtium.taxa(page: 3, per_page: 2)
      assert_equal(2, res['per_page'])
    end
  end

  def test_taxa_only_id
    VCR.use_cassette("test_taxa_only_id") do
      res = Nasturtium.taxa(only_id: true)
      res['results'].each do |r|
        assert_not_includes(r, 'rank')
      end
    end
  end

  def test_taxa_only_id_false
    VCR.use_cassette("test_taxa_only_id_false") do
      res = Nasturtium.taxa(only_id: false)
      res['results'].each do |r|
        assert_includes(r, 'rank')
      end
    end
  end

  def test_taxa_all_names
    VCR.use_cassette("test_taxa_all_names") do
      res = Nasturtium.taxa(all_names: true, order: 'desc', order_by: 'observations_count', rank: 'species')
      res['results'].each do |r|
        assert_includes(r, 'names')
      end
    end
  end

  def test_taxa_ordering
    VCR.use_cassette("test_taxa_ordering") do
      res = Nasturtium.taxa(order: 'desc', order_by: 'id')
      prev = 99999999999999999999999999999999999999999999999999999
      res['results'].each do |r|
        assert_true(r['id'] < prev)
        prev = r['id']
      end
    end
  end

  def test_taxa_ordering_asc
    VCR.use_cassette("test_taxa_ordering_asc") do
      res = Nasturtium.taxa(order: 'asc', order_by: 'id')
      prev = 0
      res['results'].each do |r|
        assert_true(r['id'] > prev)
        prev = r['id']
      end
    end
  end

  def test_taxa_obs_count_desc
    VCR.use_cassette("test_taxa_obs_count_desc") do
      res = Nasturtium.taxa(order: 'desc', order_by: 'observations_count', rank: 'species')
      prev = 99999999999999999999999999999999999999999999999999999
      res['results'].each do |r|
        assert_true(r['observations_count'] < prev)
        prev = r['observations_count']
      end
    end
  end

  def test_taxa_obs_count_asc
    VCR.use_cassette("test_taxa_obs_count_asc") do
      res = Nasturtium.taxa(order: 'asc', order_by: 'observations_count', rank: 'species')
      prev = 0
      res['results'].each do |r|
        assert_true(r['observations_count'] >= prev)
        prev = r['observations_count']
      end
    end
  end

  # TODO: not sure if locale works or how to test it

  def test_taxa_preferred_place_id
    VCR.use_cassette("test_taxa_preferred_place_id") do
      res = Nasturtium.taxa(q: 'Danaus plexippus', preferred_place_id: 6903, rank: 'species')
      assert_equal('君主斑蝶', res['results'][0]['preferred_common_name'])
    end
  end

end