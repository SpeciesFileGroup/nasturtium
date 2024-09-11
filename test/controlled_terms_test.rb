require_relative "test_helper"

class TestUser < Test::Unit::TestCase
  def setup
    @per_page = 10
  end

  def test_controlled_term
    VCR.use_cassette("test_controlled_term") do
      res = Nasturtium.controlled_terms(per_page: @per_page)
      res['results'].each do |term|
        assert_false(term['label'].nil?)
      end
    end
  end

  def test_controlled_term_for_taxon
    VCR.use_cassette("test_controlled_term_for_taxon") do
      res = Nasturtium.controlled_terms(taxon_id: 1, per_page: @per_page)
      passed = false
      res['results'].each do |term|
        if term['label'] == 'Life Stage'
            term['values'].each do |value|
                if value['label'] == 'Adult'
                    passed = true
                end
            end
        end
      end
      assert_true(passed)
    end
  end

end