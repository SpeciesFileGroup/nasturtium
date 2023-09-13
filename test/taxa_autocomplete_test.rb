require_relative "test_helper"

class TestTaxaAutocomplete < Test::Unit::TestCase

  def test_taxa_autocomplete_q
    VCR.use_cassette("test_taxa_autocomplete_q") do
      res = Nasturtium.taxa_autocomplete(q: 'Ladona ')
      assert_includes(res['results'][0]['name'], 'Ladona')
    end
  end

  def test_taxa_autocomplete_active
    VCR.use_cassette("test_taxa_autocomplete_active") do
      res = Nasturtium.taxa_autocomplete(q: 'Sinapis', is_active: true, rank: 'species')
      res['results'].each do |r|
        assert_true(r['is_active'])
      end
    end
  end

  def test_taxa_autocomplete_inactive
    VCR.use_cassette("test_taxa_autocomplete_inactive") do
      res = Nasturtium.taxa_autocomplete(q: 'Sinapis', is_active: false, rank: 'species')
      res['results'].each do |r|
        assert_false(r['is_active'])
      end
    end
  end

  def test_taxa_autocomplete_rank
    VCR.use_cassette("test_taxa_autocomplete_rank") do
      res = Nasturtium.taxa_autocomplete(q: 'Sinapis', rank: 'genus')
      res['results'].each do |r|
        assert_equal('genus', r['rank'])
      end
    end
  end

  def test_taxa_autocomplete_rank_level
    VCR.use_cassette("test_taxa_autocomplete_rank_level") do
      res = Nasturtium.taxa_autocomplete(q: 'Sinapis', rank_level: 20)
      res['results'].each do |r|
        assert_equal('genus', r['rank'])
      end
    end
  end

  def test_taxa_autocomplete_all_names
    VCR.use_cassette("test_taxa_autocomplete_all_names") do
      res = Nasturtium.taxa_autocomplete(q: 'Sinapis', rank: 'genus,species', all_names: true)
      res['results'].each do |r|
        assert_includes(r, 'names')
      end
    end
  end

  def test_taxa_autocomplete_preferred_place_id
    VCR.use_cassette("test_taxa_autocomplete_preferred_place_id") do
      res = Nasturtium.taxa_autocomplete(q: 'Danaus plexippus', preferred_place_id: 6903, rank: 'species')
      assert_equal('君主斑蝶', res['results'][0]['preferred_common_name'])
    end
  end

  def test_taxa_autocomplete_pagination_limit
    VCR.use_cassette("test_taxa_autocomplete_pagination") do
      res = Nasturtium.taxa_autocomplete(q: 'Sinapis', per_page: 1)
      assert_equal(1, res['per_page'])
    end
  end

end