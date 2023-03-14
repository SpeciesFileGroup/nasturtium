require_relative "test_helper"

class TestSearch < Test::Unit::TestCase

  def test_search_sources
    VCR.use_cassette("test_search_sources") do
      res = Inaturalia.search(q: 'oak', sources: 'taxa')
      res['results'].each do |r|
        assert_equal('Taxon', r['type'])
      end
    end
  end

  def test_search_place_id
    VCR.use_cassette("test_search_place_id") do
      res = Inaturalia.search(q: 'oak', place_id: '35')
      res['results'].each do |r|
        assert_includes(r['record']['associated_place_ids'], 35)
      end
    end
  end

  def test_search_preferred_place_id
    VCR.use_cassette("test_search_preferred_place_id") do
      res = Inaturalia.search(q: 'Danaus plexippus', preferred_place_id: 6903)
      assert_equal('君主斑蝶', res['results'][0]['record']['preferred_common_name'])
    end
  end

  def test_search_pagination_offset
    VCR.use_cassette("test_search_pagination") do
      res = Inaturalia.search(q: 'oak', page: 2, per_page: 1)
      assert_equal(2, res['page'])
    end
  end

  def test_search_pagination_limit
    VCR.use_cassette("test_search_pagination") do
      res = Inaturalia.search(q: 'oak', page: 2, per_page: 1)
      assert_equal(1, res['per_page'])
    end
  end
end