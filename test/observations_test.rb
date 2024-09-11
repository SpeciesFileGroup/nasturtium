require_relative "test_helper"
require 'date'

class TestObservations < Test::Unit::TestCase
  def setup
    @per_page = 10
  end

  def test_observations_id
    VCR.use_cassette("test_observations_id") do
      res = Nasturtium.observations(id: '150842485')
      assert_equal(150842485, res['results'][0]['id'])
    end
  end

  def test_observations_not_id
    VCR.use_cassette("test_observations_not_id") do
      res = Nasturtium.observations(id_above: 1000, id_below: 2000, only_id: true)
      ids = []
      res['results'].each do |r|
        ids.append(r['id'])
      end
      not_ids = ids.join(',')
      res = Nasturtium.observations(id_above: 1000, id_below: 2000, not_id: not_ids, only_id: true)
      res['results'].each do |r|
        assert_not_include(ids, r['id'])
      end
    end
  end

  def test_observations_acc
    VCR.use_cassette('test_observations_acc') do
      res = Nasturtium.observations(acc: true, per_page: @per_page)
      res['results'].each do |r|
        assert_not_nil(r['positional_accuracy'])
      end
    end
  end

  def test_observations_acc_false
    VCR.use_cassette('test_observations_acc_false') do
      res = Nasturtium.observations(acc: false, per_page: @per_page)
      res['results'].each do |r|
        assert_nil(r['positional_accuracy'])
      end
    end
  end

  def test_observations_captive
    VCR.use_cassette('test_observations_captive') do
      res = Nasturtium.observations(captive: true, per_page: @per_page)
      res['results'].each do |r|
        assert_true(r['captive'])
      end
    end
  end

  def test_observations_captive_false
    VCR.use_cassette('test_observations_captive_false') do
      res = Nasturtium.observations(captive: false, per_page: @per_page)
      res['results'].each do |r|
        assert_false(r['captive'])
      end
    end
  end

  def test_observations_endemic
    VCR.use_cassette('test_observations_endemic') do
      res = Nasturtium.observations(endemic: true, per_page: @per_page)
      res['results'].each do |r|
        assert_true(r['taxon']['endemic'])
      end
    end
  end

  def test_observations_endemic_false
    VCR.use_cassette('test_observations_endemic_false') do
      res = Nasturtium.observations(endemic: false, per_page: @per_page)
      res['results'].each do |r|
        assert_false(r['taxon']['endemic'])
      end
    end
  end

  def test_observations_geo
    VCR.use_cassette('test_observations_geo') do
      res = Nasturtium.observations(geo: true, per_page: @per_page)
      res['results'].each do |r|
        assert_not_nil(r['geojson'])
      end
    end
  end

  def test_observations_geo_false
    VCR.use_cassette('test_observations_geo_false') do
      res = Nasturtium.observations(geo: false, per_page: @per_page)
      res['results'].each do |r|
        assert_nil(r['geojson'])
      end
    end
  end

  def test_observations_identified
    VCR.use_cassette('test_observations_identified') do
      res = Nasturtium.observations(identified: true, per_page: @per_page)
      res['results'].each do |r|
        assert_true(r['identifications'].size > 0)
      end
    end
  end

  # def test_observations_identified_false
  #   VCR.use_cassette('test_observations_identified_false') do
  #     res = Nasturtium.observations(identified: false, per_page: @per_page)
  #     res['results'].each do |r|
  #       assert_false(r['identifications'].size > 0)
  #     end
  #   end
  # end

  def test_observations_introduced
    VCR.use_cassette('test_observations_introduced') do
      res = Nasturtium.observations(introduced: true, per_page: @per_page)
      res['results'].each do |r|
        assert_true(r['taxon']['introduced'])
      end
    end
  end

  def test_observations_introduced_false
    VCR.use_cassette('test_observations_introduced_false') do
      res = Nasturtium.observations(introduced: false, per_page: @per_page)
      res['results'].each do |r|
        assert_false(r['taxon']['introduced'])
      end
    end
  end

  def test_observations_mappable
    VCR.use_cassette('test_observations_mappable') do
      res = Nasturtium.observations(mappable: true, per_page: @per_page)
      res['results'].each do |r|
        assert_true(r['mappable'])
      end
    end
  end

  def test_observations_mappable_false
    VCR.use_cassette('test_observations_mappable_false') do
      res = Nasturtium.observations(mappable: false, per_page: @per_page)
      res['results'].each do |r|
        assert_false(r['mappable'])
      end
    end
  end

  def test_observations_native
    VCR.use_cassette('test_observations_native') do
      res = Nasturtium.observations(native: true, per_page: @per_page)
      res['results'].each do |r|
        assert_true(r['taxon']['native'])
      end
    end
  end

  def test_observations_native_false
    VCR.use_cassette('test_observations_native_false') do
      res = Nasturtium.observations(native: false, per_page: @per_page)
      res['results'].each do |r|
        assert_false(r['taxon']['native'])
      end
    end
  end

  def test_observations_out_of_range
    VCR.use_cassette('test_observations_out_of_range') do
      res = Nasturtium.observations(out_of_range: true, per_page: @per_page)
      res['results'].each do |r|
        assert_true(r['out_of_range'])
      end
    end
  end

  def test_observations_out_of_range_false
    VCR.use_cassette('test_observations_out_of_range_false') do
      res = Nasturtium.observations(out_of_range: false, per_page: @per_page)
      res['results'].each do |r|
        assert_false(r['out_of_range'])
      end
    end
  end

  # TODO: not sure how to test
  def test_observations_pcid
    VCR.use_cassette('test_observations_pcid') do
      total = Nasturtium.observations(per_page: 0)
      res = Nasturtium.observations(pcid: true, project_id: 70043, per_page: 0)
      assert_true(res['total_results'] < total['total_results'])
    end
  end


  def test_observations_photos
    VCR.use_cassette('test_observations_photos') do
      res = Nasturtium.observations(photos: true, per_page: @per_page)
      res['results'].each do |r|
        assert_true(r['photos'].size > 0)
      end
    end
  end

  # TODO: iNaturalist bug? photos=false returns some observations with photos
  # def test_observations_photos_false
  #   VCR.use_cassette('test_observations_photos_false') do
  #     res = Nasturtium.observations(photos: false, per_page: @per_page)
  #     res['results'].each do |r|
  #       assert_true(r['photos'].size == 0)
  #     end
  #   end
  # end

  def test_observations_popular
    VCR.use_cassette('test_observations_popular') do
      res = Nasturtium.observations(popular: true, per_page: @per_page)
      res['results'].each do |r|
        assert_true(r['faves'].size > 0)
      end
    end
  end

  def test_observations_popular_false
    VCR.use_cassette('test_observations_popular_false') do
      res = Nasturtium.observations(popular: false, per_page: @per_page)
      res['results'].each do |r|
        assert_true(r['faves'].size == 0)
      end
    end
  end

  def test_observations_sounds
    VCR.use_cassette('test_observations_sounds') do
      res = Nasturtium.observations(sounds: true, per_page: @per_page)
      res['results'].each do |r|
        assert_true(r['sounds'].size > 0)
      end
    end
  end

  def test_observations_sounds_false
    VCR.use_cassette('test_observations_sounds_false') do
      res = Nasturtium.observations(sounds: false, per_page: @per_page)
      res['results'].each do |r|
        assert_true(r['sounds'].size == 0)
      end
    end
  end

  def test_observations_taxon_active
    VCR.use_cassette('test_observations_taxon_active') do
      res = Nasturtium.observations(taxon_is_active: true, per_page: @per_page)
      res['results'].each do |r|
        assert_true(r['taxon']['is_active'])
      end
    end
  end

  # TODO: iNaturalist bug? some return true
  # def test_observations_taxon_active_false
  #   VCR.use_cassette('test_observations_taxon_active_false') do
  #     res = Nasturtium.observations(taxon_is_active: false, per_page: @per_page)
  #     res['results'].each do |r|
  #       assert_false(r['taxon']['is_active'])
  #     end
  #   end
  # end

  def test_observations_threatened
    VCR.use_cassette('test_observations_threatened') do
      res = Nasturtium.observations(threatened: true, per_page: @per_page)
      res['results'].each do |r|
        assert_true(r['taxon']['threatened'])
      end
    end
  end

  def test_observations_threatened_false
    VCR.use_cassette('test_observations_threatened_false') do
      res = Nasturtium.observations(threatened: false, per_page: @per_page)
      res['results'].each do |r|
        assert_false(r['taxon']['threatened'])
      end
    end
  end

  def test_observations_verifiable
    VCR.use_cassette('test_observations_verifiable') do
      res = Nasturtium.observations(verifiable: true, per_page: @per_page)
      res['results'].each do |r|
        assert_include(%w[needs_id research], r['quality_grade'])
      end
    end
  end

  def test_observations_verifiable_false
    VCR.use_cassette('test_observations_verifiable_false') do
      res = Nasturtium.observations(verifiable: false, per_page: @per_page)
      res['results'].each do |r|
        assert_equal('casual', r['quality_grade'])
      end
    end
  end

  def test_observations_quality_grade
    VCR.use_cassette('test_observations_quality_grade') do
      res = Nasturtium.observations(quality_grade: 'research', per_page: @per_page)
      res['results'].each do |r|
        assert_equal('research', r['quality_grade'])
      end
    end
  end


  # TODO: iNaturalist bug with licensed=true returning observations with license_code=''? https://api.inaturalist.org/v1/observations?licensed=true&photo_licensed=true
  #   Their API documentation says "License attribute of an observation must not be null" so technically it's right but users probably expect observations with a license
  def test_observations_licensed
    VCR.use_cassette("test_observations_licensed") do
      res = Nasturtium.observations(licensed: true, per_page: @per_page)
      res['results'].each do |r|
        assert_not_nil(r['license_code'])
      end
    end
  end

  def test_observations_photo_licensed
    VCR.use_cassette("test_observations_photo_licensed") do
      res = Nasturtium.observations(photo_licensed: true, per_page: @per_page)
      res['results'].each do |r|
        licensed = false
        r['photos'].each do |p|
          licensed = true unless p['license_code'].nil?
        end
        assert_true(licensed)
      end
    end
  end

  # TODO: iNaturalist bug? If you don't include photos=true with photo_licensed=false, you get photos with licenses
  def test_observations_photo_licensed_false
    VCR.use_cassette("test_observations_photo_licensed_false") do
      res = Nasturtium.observations(photo_licensed: false, photos: true, per_page: @per_page)
      res['results'].each do |r|
        licensed = false
        r['photos'].each do |p|
          licensed = true unless p['license_code'].nil?
        end
        assert_false(licensed)
      end
    end
  end

  def test_observations_photo_license
    VCR.use_cassette("test_observations_photo_license") do
      res = Nasturtium.observations(photo_license: 'cc0', per_page: @per_page)
      res['results'].each do |r|
        at_least_one_photo_is_cc0_licensed = false
        r['photos'].each do |p|
          if p['license_code'] == 'cc0'
            at_least_one_photo_is_cc0_licensed = true
          end
        end
        assert_true(at_least_one_photo_is_cc0_licensed)
      end
    end
  end

  def test_observations_ofv_datatype
    VCR.use_cassette('test_observations_ofv_datatype') do
      res = Nasturtium.observations(ofv_datatype: 'dna', per_page: @per_page)
      res['results'].each do |r|
        at_least_one_ofv_has_dna_datatype = false
        r['ofvs'].each do |ofvs|
          if ofvs.key? 'datatype' and ofvs['datatype'] == 'dna'
            at_least_one_ofv_has_dna_datatype = true
          end
        end
        assert_true(at_least_one_ofv_has_dna_datatype)
      end
    end
  end

  def test_observations_place_id
    VCR.use_cassette("test_observations_place_id") do
      res = Nasturtium.observations(place_id: 26, per_page: @per_page)
      res['results'].each do |r|
        assert_include(r['place_ids'], 26)
      end
    end
  end

  # TODO: iNaturalist bug? project_ids are empty, but it does filter to project, so testing observation timezone
  def test_observations_project_id
    VCR.use_cassette("test_observations_project_id") do
      res = Nasturtium.observations(project_id: '22499', per_page: @per_page)
      res['results'].each do |r|
        assert_equal('America/Chicago', r['observed_time_zone'] )
      end
    end
  end

  def test_observations_rank
    VCR.use_cassette("test_observations_rank") do
      res = Nasturtium.observations(rank: 'subspecies', per_page: @per_page)
      res['results'].each do |r|
        assert_equal('subspecies', r['taxon']['rank'])
      end
    end
  end

  def test_site_id
    VCR.use_cassette("test_site_id") do
      res = Nasturtium.observations(site_id: '2', per_page: @per_page)
      res['results'].each do |r|
        assert_equal(2, r['site_id'])
      end
    end
  end

  def test_observations_sound_license
    VCR.use_cassette("test_observations_sound_license") do
      res = Nasturtium.observations(sound_license: 'cc0')
      res['results'].each do |r|
        at_least_one_sound_is_cc0_licensed = false
        r['sounds'].each do |p|
          if p['license_code'] == 'cc0'
            at_least_one_sound_is_cc0_licensed = true
          end
        end
        assert_true(at_least_one_sound_is_cc0_licensed)
      end
    end
  end

  # TODO: iNaturalist bug? taxon_id matches parent_id=522193 but documented as "Only show observations of these taxa and their descendants"
  #   https://api.inaturalist.org/v1/observations/151226266 has taxon.id = 852458, taxon.parent_id=522193
  def test_observations_taxon_id
    VCR.use_cassette("test_observations_taxon_id") do
      res = Nasturtium.observations(taxon_id: '522193', per_page: @per_page)
      res['results'].each do |r|
        includes_id = (r['taxon']['id'] == 522193 or r['taxon']['parent_id'] == 522193)
        assert_true(includes_id)
      end
    end
  end

  def test_observations_without_taxon_id
    VCR.use_cassette("test_observations_without_taxon_id") do
      res = Nasturtium.observations(q: 'Cyphoderris', without_taxon_id: '473752', per_page: @per_page)
      res['results'].each do |r|
        assert_not_equal(473752, r['taxon']['id'])
      end
    end
  end

  def test_observations_taxon_name
    VCR.use_cassette("test_observations_taxon_name") do
      res = Nasturtium.observations(taxon_name: 'Cyphoderris strepitans', per_page: @per_page)
      res['results'].each do |r|
        assert_equal('Cyphoderris strepitans', r['taxon']['name'])
      end
    end
  end

  def test_observations_user_id
    VCR.use_cassette("test_observations_user_id") do
      res = Nasturtium.observations(user_id: '20717', per_page: @per_page)
      res['results'].each do |r|
        assert_equal(20717, r['user']['id'])
      end
    end
  end

  def test_observations_user_login
    VCR.use_cassette("test_observations_user_login") do
      res = Nasturtium.observations(user_login: 'debpaul', per_page: @per_page)
      res['results'].each do |r|
        assert_equal(20717, r['user']['id'])
      end
    end
  end

  def test_observations_ident_user_id
    VCR.use_cassette("test_observations_ident_user_id") do
      res = Nasturtium.observations(ident_user_id: '20717', per_page: @per_page)
      res['results'].each do |r|
        identified_by_user = false
        r['identifications'].each do |i|
          if i['user']['id'] == 20717
            identified_by_user = true
          end
        end
        assert_true(identified_by_user)
      end
    end
  end

  def test_observations_date
    VCR.use_cassette("test_observations_date") do
      res = Nasturtium.observations(year: 2020, month: 3, day: 15)
      res['results'].each do |r|
        assert_equal('2020-03-15', r['observed_on'])
      end
    end
  end

  def test_observations_term_id
    VCR.use_cassette("test_observations_term_id") do
      res = Nasturtium.observations(term_id: 1)
      res['results'].each do |r|
        has_term_in_at_least_one_annotation = false
        r['annotations'].each do |a|
          if a['controlled_attribute_id'] == 1
            has_term_in_at_least_one_annotation = true
          end
        end
        assert_true(has_term_in_at_least_one_annotation)
      end
    end
  end

  def test_observations_without_term_id
    VCR.use_cassette("test_observations_without_term_id") do
      res = Nasturtium.observations(term_id: 1, without_term_id: 17)
      res['results'].each do |r|
        r['annotations'].each do |a|
          assert_not_equal(17, a['controlled_attribute_id'])
        end
      end
    end
  end

  def test_observations_term_value_id
    VCR.use_cassette("test_observations_term_value_id") do
      res = Nasturtium.observations(term_id: 1, term_value_id: 2)
      res['results'].each do |r|
        has_term_value_in_at_least_one_annotation = false
        r['annotations'].each do |a|
          if a['controlled_value_id'] == 2
            has_term_value_in_at_least_one_annotation = true
          end
        end
        assert_true(has_term_value_in_at_least_one_annotation)
      end
    end
  end

  def test_observations_term_without_value_id
    VCR.use_cassette("test_observations_term_without_value_id") do
      res = Nasturtium.observations(term_id: 1, without_term_value_id: 2)
      res['results'].each do |r|
        r['annotations'].each do |a|
          assert_not_equal('1|2', a['concatenated_attr_val'])
        end
      end
    end
  end

  def test_observations_acc_above
    VCR.use_cassette("test_observations_acc_above") do
      res = Nasturtium.observations(acc_above: 10, per_page: @per_page)
      res['results'].each do |r|
        assert_true(r['positional_accuracy'] > 10)
      end
    end
  end

  def test_observations_acc_below
    VCR.use_cassette("test_observations_acc_below") do
      res = Nasturtium.observations(acc_below: 10, per_page: @per_page)
      res['results'].each do |r|
        assert_true(r['positional_accuracy'] < 10)
      end
    end
  end

  def test_observations_acc_below_or_unknown
    VCR.use_cassette("test_observations_acc_below_or_unknown") do
      res = Nasturtium.observations(acc_below_or_unknown: 10, per_page: @per_page)
      at_least_one_nil = false
      res['results'].each do |r|
        if r['positional_accuracy'].nil?
          at_least_one_nil = true
        end
      end
      assert_true(at_least_one_nil)
    end
  end

  def test_observations_obs_date_range
    VCR.use_cassette("test_observations_obs_date_range") do
      res = Nasturtium.observations(after: '2020-01-01', before: '2020-01-03', per_page: @per_page)
      res['results'].each do |r|
        assert_include(%w[2020-01-01 2020-01-02 2020-01-03], r['observed_on'])
      end
    end
  end

  def test_observations_observed_on
    VCR.use_cassette("test_observations_observed_on") do
      res = Nasturtium.observations(observed_on: '2020-01-02', per_page: @per_page)
      res['results'].each do |r|
        assert_equal('2020-01-02', r['observed_on'])
      end
    end
  end

  def test_observations_created_date_range
    VCR.use_cassette("test_observations_created_date_range") do
      res = Nasturtium.observations(created_after: '2020-01-01', created_before: '2020-01-03', per_page: @per_page)
      res['results'].each do |r|
        assert_include(%w[2020-01-01 2020-01-02 2020-01-03], r['created_at_details']['date'])
      end
    end
  end

  def test_observations_created_on
    VCR.use_cassette("test_observations_created_on") do
      res = Nasturtium.observations(created_on: '2020-01-02', per_page: @per_page)
      res['results'].each do |r|
        assert_include(%w[2020-01-01 2020-01-02 2020-01-03], r['created_at_details']['date'])
      end
    end
  end

  def test_observations_conservation_status
    VCR.use_cassette("test_observations_conservation_status") do
      res = Nasturtium.observations(conservation_status: 'endangered', per_page: @per_page)
      res['results'].each do |r|
        assert_equal('endangered', r['taxon']['conservation_status']['status'])
        end
    end
  end

  # TODO: csa parameter might not work in iNaturalist API, unless there are IDs for the authorities?
  # def test_conservation_status_authority
  #   res = Nasturtium.observations(conservation_status_authority: 'IUCN Red List', per_page: @per_page)
  #   res['results'].each do |r|
  #     assert_equal('IUCN Red List', r['taxon']['conservation_status']['authority'])
  #   end
  # end

  def tes_observationst_conservation_status_iucn
    VCR.use_cassette("test_observations_conservation_status_iucn") do
      res = Nasturtium.observations(conservation_status_iucn: 'VU', per_page: @per_page)
      res['results'].each do |r|
        assert_equal('vulnerable', r['taxon']['conservation_status']['status_name'])
      end
    end
  end

  def test_observations_geoprivacy
    VCR.use_cassette("test_observations_geoprivacy") do
      res = Nasturtium.observations(geoprivacy: 'obscured', per_page: @per_page)
      res['results'].each do |r|
        assert_equal('obscured', r['geoprivacy'])
      end
    end
  end

  def test_observations_taxon_geoprivacy
    VCR.use_cassette("test_observations_taxon_geoprivacy") do
      res = Nasturtium.observations(taxon_geoprivacy: 'obscured', per_page: @per_page)
      res['results'].each do |r|
        assert_equal('obscured', r['taxon_geoprivacy'])
      end
    end
  end

  def test_observations_taxon_rank_highest
    VCR.use_cassette("test_observations_taxon_rank_highest") do
      res = Nasturtium.observations(rank_highest: 'genus', per_page: @per_page)
      res['results'].each do |r|
        assert_include(%w[genus section species subspecies], r['taxon']['rank'])
      end
    end
  end

  def test_observations_taxon_rank_lowest
    VCR.use_cassette("test_observations_taxon_rank_lowest") do
      res = Nasturtium.observations(rank_lowest: 'phylum', per_page: @per_page)
      res['results'].each do |r|
        assert_include(%w[stateofmatter kingdom phylum], r['taxon']['rank'])
      end
    end
  end

  def test_observations_iconic_taxa
    VCR.use_cassette("tes_observations_iconic_taxa") do
      res = Nasturtium.observations(iconic_taxa: 'Plantae', per_page: @per_page)
      res['results'].each do |r|
        assert_equal('Plantae', r['taxon']['iconic_taxon_name'])
      end
    end
  end

  def test_observations_id_range
    VCR.use_cassette("test_observations_id_range") do
      res = Nasturtium.observations(id_above: 1000, id_below: 2000, per_page: @per_page)
      res['results'].each do |r|
        in_range = (r['id'] < 2000 and r['id'] > 1000)
        assert_true(in_range)
      end
    end
  end

  def test_observations_identifications_status
    VCR.use_cassette("test_observations_identifications_status") do
      res = Nasturtium.observations(identifications: 'most_agree', per_page: @per_page)
      res['results'].each do |r|
        assert_true(r['identifications_most_agree'])
      end
    end
  end

  def test_observations_identifications_coordinate
    VCR.use_cassette("test_observations_identifications_coordinate") do
      res = Nasturtium.observations(latitude: 45.703259, longitude: -85.552406, radius: 1, per_page: @per_page)
      res['results'].each do |r|
        obs_lat = r['location'].split(',')[0].to_f
        obs_lng = r['location'].split(',')[1].to_f
        latitude_passed = (obs_lat <= 45.712211 and obs_lat >= 45.694307)
        longitude_passed = (obs_lng <= -85.5395 and obs_lng >= -85.5653)
        assert_true(latitude_passed)
        assert_true(longitude_passed)
      end
    end
  end

  def test_observations_identifications_bounding_box
    VCR.use_cassette("test_observations_identifications_bounding_box") do
      res = Nasturtium.observations(ne_latitude: 68.502512, ne_longitude: -133.979710, sw_latitude: 67.996777, sw_longitude: -135.217870, per_page: @per_page)
      res['results'].each do |r|
        obs_lat = r['location'].split(',')[0].to_f
        obs_lng = r['location'].split(',')[1].to_f
        latitude_passed = (obs_lat <= 68.502512 and obs_lat >= 67.996777)
        longitude_passed = (obs_lng <= -133.979710 and obs_lng >= -135.217870)
        assert_true(latitude_passed)
        assert_true(longitude_passed)
      end
    end
  end

  # TODO: not really sure how lists work, and there is no lists endpoint to find them?
  def test_observations_list_id
    VCR.use_cassette("test_observations_list_id") do
      total = Nasturtium.observations(per_page: 0)
      res = Nasturtium.observations(list_id: 92876, per_page: @per_page)
      assert_true(res['total_results'] < total['total_results'])
    end
  end

  def test_observations_q
    VCR.use_cassette("test_observations_q") do
      res = Nasturtium.observations(q: 'Parastratiosphecomyia', per_page: @per_page)
      res['results'].each do |r|
        assert_include(r.to_s, 'Parastratiosphecomyia')
      end
    end
  end

  def test_observations_q_search_on
    VCR.use_cassette("test_observations_q_search_on") do
      q = 'purple'
      res = Nasturtium.observations(q: q, search_on: 'tags', per_page: @per_page)
      res['results'].each do |r|
        passed = false
        r['tags'].each do |t|
          if t.downcase.include? 'purple'
            passed = true
          end
        end
        assert_true(passed)
      end
    end
  end

  def test_observations_ttl
    VCR.use_cassette("test_observations_ttl") do
      res = Nasturtium.observations(ttl: 12345, per_page: 0, headers: true)
      assert_equal('public, max-age=12345', res['cache-control'])
    end
  end

  def test_observations_updated_since
    VCR.use_cassette("test_observations_updated_since") do
      date_str = '2023-09-11T23:59:59-00:00'
      date = DateTime.parse(date_str)
      res = Nasturtium.observations(updated_since: date_str, order_by: 'created', order: 'asc', per_page: @per_page)
      res['results'].each do |r|
        assert_true(date <= DateTime.parse(r['updated_at']))
      end
    end
  end

  def test_observations_reviewed
    VCR.use_cassette("test_observations_reviewed") do
      viewer = 20717
      res = Nasturtium.observations(reviewed: true, viewer_id: viewer, per_page: @per_page)
      res['results'].each do |r|
        assert_includes(r['reviewed_by'], viewer)
      end
    end
  end


  # TODO: iNaturalist bug? currently throws 500 error
  # def test_observations_locale

  #   def is_zh(char)
  #     if char >= 0x4E00 && char <= 0x9FFF
  #       return true
  #     end
  #     if char >= 0x3400 && char <= 0x4DBF
  #       return true
  #     end
  #     if char >= 0x20000 && char <= 0x2A6DF
  #       return true
  #     end
  #     if char >= 0x2A700 && char <= 0x2B73F
  #       return true
  #     end
  #     return false
  #   end

  #   VCR.use_cassette("test_observations_locale") do
  #     res = Nasturtium.observations(locale: 'zh')
  #     res['results'].each do |r|
  #       unless r['taxon'].nil? or r['taxon']['preferred_common_name'].nil?
  #         chars = r.dig('taxon', 'preferred_common_name').unpack('U*')
  #         chars.each do |char|
  #           assert_true(is_zh(char))
  #         end
  #       end
  #     end
  #   end
  # end

  # TODO: does preferred_place_id work? setting preferred_place_id=6903, returns common names in English for some taxa
  def test_observations_preferred_place_id
    VCR.use_cassette("test_observations_preferred_place_id") do
      res = Nasturtium.observations(preferred_place_id: 6903, per_page: @per_page)
      res['results'].each do |r|
  
      end
    end
  end

  def test_observations_pagination_offset
    VCR.use_cassette("test_observations_pagination") do
      res = Nasturtium.observations(only_id: true, page: 10, per_page: 1)
      assert_equal(10, res['page'])
    end
  end

  def test_observations_pagination_limit
    VCR.use_cassette("test_observations_pagination") do
      res = Nasturtium.observations(only_id: true, page: 10, per_page: 1)
      assert_equal(1, res['per_page'])
    end
  end
end