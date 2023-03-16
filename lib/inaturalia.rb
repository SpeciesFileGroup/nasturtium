# frozen_string_literal: true

require "erb"
require_relative "inaturalia/version"
require_relative "inaturalia/request"
require "inaturalia/helpers/configuration"

module Inaturalia
  extend Configuration

  define_setting :base_url, "https://api.inaturalist.org/v1/"
  define_setting :mailto, ENV["INATURALIA_API_EMAIL"]

  # Search places, projects, taxa, users
  # @param q [String, nil] A search query
  # @param sources [Array, String, nil] Type of record to search (places, projects, taxa, users)
  # @param place_id [String, nil] Filter to an array of place_ids (TODO: place_id is an array in the documentation but doesn't seem to work even with their example?)
  # @param preferred_place_id [Integer, nil] Place of preference for regional taxon common names
  # @param locale [String, nil] Locale preference for taxon common names (e.g., en-US)
  #
  # @param page [Integer, nil] The results page number
  # @param per_page [Integer, nil] The results limit
  # @param verbose [Boolean] Print headers to STDOUT
  #
  # @return [Array, Boolean] A hash with search results
  def self.search(q: nil, sources: nil, place_id: nil, preferred_place_id: nil, locale: nil, page: nil, per_page: nil,
                  verbose: false)
    endpoint = 'search'
    Request.new(
      endpoint: endpoint,
      q: q,
      sources: sources,
      place_id: place_id,
      preferred_place_id: preferred_place_id,
      locale: locale,
      page: page,
      per_page: per_page,
      verbose: verbose
    ).perform
  end

  # TODO: iNatualist API documentation does not include sound_license

  # Get observations
  #
  #   Note: use the subresource parameter to access these subresource endpoints which share the same parameters as /observations:
  #     /observations/histogram
  #     /observations/identifiers
  #     /observations/observers
  #     /observations/popular_field_values
  #     /observations/species_counts
  #
  # @param subresource [String, nil] Access a subresource endpoint of observations (histogram, identifiers, observers, popular_field_values, species_counts)
  #
  # @param q [String, nil] An observation properties search query
  # @param search_on [String, nil] Observation properties to search on (names, tags, description, place)
  # @param id [String, Integer, nil] A comma-separated list of observation IDs
  # @param not_id [String, Integer, nil] A comma-separated list of observation IDs that must not be included
  # @param acc [Boolean, nil] Filter by whether the positional accuracy/coordinate uncertainty was specified
  # @param captive [Boolean, nil] Filter on whether it was captive/cultivated observations
  # @param endemic [Boolean, nil] Filter on whether observations were of taxa endemic to their location
  # @param geo [Boolean, nil] Filter to only georeferenced observations
  # @param identified [Boolean, nil] Filter to only observations with community identifications
  # @param introduced [Boolean, nil] Filter to observations of taxa that were introduced to their location
  # @param mappable [Boolean, nil] Filter to only observations that show on map tiles
  # @param native [Boolean, nil] Filter to only observations of taxa native tot heir location
  # @param out_of_range [Boolean, nil] Filter to only observations made in locations outside the taxon's known ranges
  # @param pcid [Boolean, nil] Filter to observations identified by a curator of a project
  # @param photos [Boolean, nil] Filter to observations with photos
  # @param popular [Boolean, nil] Filter to only observations that have been favorited by at least 1 user
  # @param sounds [Boolean, nil] Filter to observations with sounds
  # @param taxon_is_active [Boolean, nil] Filter to observations of active taxon concepts
  # @param threatened [Boolean, nil] Filter to observations of taxa that are threatened at their location
  # @param verifiable [Boolean, nil] Filter by observations with a quality_grade=needs_id,research
  # @param licensed [Boolean, nil] Filter by observations with a license
  # @param photo_licensed [Boolean, nil] License attribute of at least one photo in an observation must not be nil
  # @param license [String, nil] Filter by a comma-separated list of licenses (cc-by,cc-by-nc,cc-by-nd,cc-by-sa,cc-by-nc-nd,cc-by-nc-sa,cc0)
  # @param photo_license [String, nil] Filter by a comma-separated list of photo licenses (cc-by,cc-by-nc,cc-by-nd,cc-by-sa,cc-by-nc-nd,cc-by-nc-sa,cc0)
  # @param sound_license [String, nil] Filter by a comma-separated list of sound licenses (cc-by,cc-by-nc,cc-by-nd,cc-by-sa,cc-by-nc-nd,cc-by-nc-sa,cc0)
  # @param ofv_datatype [String, nil] Filter by a comma-separated list of datatypes that the observation must include  # TODO: does it take arrays?
  # @param place_id [String, Integer, nil] Filter by a comma-separated list of place_ids
  # @param project_id [String, Integer, nil] Filter by a comma-separated list of project_ids
  # @param rank [String, nil] Filter by an array of taxon ranks
  # @param site_id [String, Integer, nil] Filter by a comma-separated list of site_ids
  # @param taxon_id [String, Integer, nil] Filter by a comma-separated list of taxon_ids and their descendants
  # @param without_taxon_id [String, Integer, nil] Exclude a comma-separated list of taxon_ids and their descendants
  # @param taxon_name [String, Integer, nil] Filter by a comma-separated list of scientific or common names
  # @param user_id [String, Integer nil] Filter by observations made by a comma-separated list of user_ids
  # @param user_login [String, nil] Filter by a comma-separated list of user_logins
  # @param day [String, Integer, nil] Filter on a comma-separated list of days
  # @param month [String, Integer, nil] Filter on a comma-separated list of months
  # @param year [String, Integer, nil] Filter on a comma-separated list of years
  # @param term_id [String, Integer, nil] Filter on a comma-separated list of term_ids
  # @param without_term_id String, Integer, nil] Exclude on a comma-separated list of term_ids
  # @param term_value_id [String, Integer, nil] Filter on annotations made with this controlled value ID; must be used with term_id
  # @param without_term_value_id [String, Integer, nil] Exclude on annotations made with this controlled value ID
  # @param acc_above [String, nil] Positional accuracy must be above value
  # @param acc_below [String, nil] Positional accuracy must be below value
  # @param acc_below_or_unknown [String, nil] Positional accuracy must be below value or unknown
  # @param observed_before [String, nil] Must have been observed on or before this date (d2)
  # @param observed_on [String, nil] Must have been observed on this date
  # @param observed_after [String, nil] Must have been observed on or after this date (d1)
  # @param created_before [String, nil] Must have been created on or before this date (created_d2)
  # @param created_on [String, nil] Must have been created on this date
  # @param created_after [String, nil] Must have been created on or before this date (created_d1)
  # @param unobserved_by_user_id [String, nil] Taxon must be unobserved by the provided user_id
  # @param apply_project_rules_for [String, nil] Must match rules of the provided project_id
  # @param conservation_status [String, nil] Taxon must have this conservation status (cs) code, use with place_id to make location-specific
  # @param conservation_status_authority [String, nil] Taxon must have the conservation status from the provided authority (csa), use with place_id to make location-specific
  # @param conservation_status_iucn [String, nil] Taxon must have the provided conservation status from the IUCN, use with place_id to make location-specific
  # @param geoprivacy [String, nil] Filter by a comma-separated list of geoprivacy settings (obscured, obscured_private, open)
  # @param taxon_geoprivacy [String, nil] Filter by a comma-separated list of geoprivacy settings (obscured, obscured_private, open) of the most conservative geoprivacy associated with one of the taxa proposed in the current identifications
  # @param rank_lowest [String, nil] Taxon rank must be less than or equal to provided rank
  # @param rank_highest [String, nil] Taxon rank must be greater than or equal to provided rank
  # @param iconic_taxa [String, nil] Filter by taxa with the provided iconic taxon (Actinopterygii, Animalia, Amphibia, Arachnida, Aves, Chromista, Fungi, Insecta, Mammalia, Mollusca, Repitilia, Plantae, Protozoa, unknown)
  # @param id_below [String, Integer, nil] Most have an observation ID below the provided value
  # @param id_above [String, Integer, nil] Most have an observation ID above the provided value
  # @param identifications [String, nil] Filter by identifications status (most_agree, some_agree, most_disagree)
  # @param latitude [Double, nil] Filter by observations within a {radius} kilometer circle around the provided latitude coordinate (lat)
  # @param longitude [Double, nil] Filter by observations within a {radius} kilometer circle around the provided longitude coordinate (lng)
  # @param radius [String, Integer, Double] Filter by observations within the provided radius in kilometers
  # @param ne_latitude [Double, nil] Filter by observations within provided (nelat) bounding box (ne_latitude, ne_longitude, sw_latitude, sw_longitude)
  # @param ne_longitude [Double, nil] Filter by observations within provided (nelng) bounding box (ne_latitude, ne_longitude, sw_latitude, sw_longitude)
  # @param sw_latitude [Double, nil] Filter by observations within provided (swlat) bounding box (ne_latitude, ne_longitude, sw_latitude, sw_longitude)
  # @param sw_longitude [Double, nil] Filter by observations within provided (swlng) bounding box (ne_latitude, ne_longitude, sw_latitude, sw_longitude)
  # @param list_id [Integer, nil] Taxon must bin the list with the provided ID
  # @param not_in_project [String, nil] Observation must not be in the provided project_id or slug
  # @param not_matching_project_rules_for [String, nil] Must not match the rules of the provided project_id or slug
  # @param quality_grade [String, nil] Filter by observation quality grade (casual, needs_id, research)
  # @param updated_since [String, nil] Filter by observations updated since the provided time
  # @param reviewed [Boolean, nil] Observations have been reviewed by viewer_id
  # @param viewer_id [String, nil] Use with reviewed boolean to filter by observations reviewed by the provided viewer_id
  # @param locale [String, nil] Locale preference for taxon common names (e.g., en-US)
  # @param preferred_place_id [Integer, nil] Place of preference for regional taxon common names
  # @param ttl [String, Integer, nil] Set the Cache-Control HTTP header with a max-age value to cache the request on iNaturalist serers and within the client
  # @param only_id [Boolean, nil] Only return record IDs
  #
  # @param order [String, nil] Ascending or descending sort order (asc, desc)
  # @param order_by [String, nil] The parameter to sort by (observed_on, species_guess, votes, id, created_at)
  # @param page [Integer, nil] The results page number
  # @param per_page [Integer, nil] The results limit
  # @param headers [Boolean] Return headers instead of body
  # @param verbose [Boolean] Print headers to STDOUT
  #
  # @return [Hash, Boolean] A hash with observation results
  def self.observations(subresource: nil, q: nil, search_on: nil, id: nil, not_id: nil, acc: nil, captive: nil,
                        endemic: nil, geo: nil, identified: nil, introduced: nil, mappable: nil, native: nil,
                        out_of_range: nil, pcid: nil, photos: nil, popular: nil, sounds: nil, taxon_is_active: nil,
                        threatened: nil, verifiable: nil, licensed: nil, photo_licensed: nil,
                        photo_license: nil, sound_license: nil, ofv_datatype: nil, place_id: nil, project_id: nil,
                        rank: nil, site_id: nil, taxon_id: nil, without_taxon_id: nil, taxon_name: nil, user_id: nil,
                        user_login: nil, ident_user_id: nil, day: nil, month: nil, year: nil, term_id: nil,
                        without_term_id: nil, term_value_id: nil, without_term_value_id: nil, acc_below: nil,
                        acc_below_or_unknown: nil, acc_above: nil, observed_before: nil, observed_on: nil,
                        observed_after: nil, created_before: nil, created_on: nil, created_after: nil,
                        unobserved_by_user_id: nil, apply_project_rules_for: nil, conservation_status: nil,
                        conservation_status_authority: nil, conservation_status_iucn: nil, geoprivacy: nil,
                        taxon_geoprivacy: nil, rank_lowest: nil, rank_highest: nil, iconic_taxa: nil,
                        id_below: nil, id_above: nil, identifications: nil, latitude: nil, longitude: nil,
                        radius: nil, ne_latitude: nil, ne_longitude: nil, sw_latitude: nil, sw_longitude: nil,
                        list_id: nil, not_in_project: nil, not_matching_project_rules_for: nil, quality_grade: nil,
                        updated_since: nil, viewer_id: nil, reviewed: nil, locale: nil, preferred_place_id: nil,
                        only_id: nil, ttl: nil, order: nil, order_by: nil, page: nil, per_page: nil, headers: false,
                        verbose: false)
    endpoint = 'observations'
    endpoint = "#{endpoint}/#{subresource}" unless subresource.nil?

    Request.new(endpoint: endpoint,
                q: q,
                search_on: search_on,
                id: id,
                not_id: not_id,
                acc: acc,
                captive: captive,
                endemic: endemic,
                geo: geo,
                identified: identified,
                introduced: introduced,
                mappable: mappable,
                native: native,
                out_of_range: out_of_range,
                pcid: pcid,
                photos: photos,
                popular: popular,
                sounds: sounds,
                taxon_is_active: taxon_is_active,
                threatened: threatened,
                verifiable: verifiable,
                licensed: licensed,
                photo_licensed: photo_licensed,
                photo_license: photo_license,
                sound_license: sound_license,
                ofv_datatype: ofv_datatype,
                place_id: place_id,
                project_id: project_id,
                rank: rank,
                site_id: site_id,
                taxon_id: taxon_id,
                without_taxon_id: without_taxon_id,
                taxon_name: taxon_name,
                user_id: user_id,
                user_login: user_login,
                ident_user_id: ident_user_id,
                day: day,
                month: month,
                year: year,
                term_id: term_id,
                without_term_id: without_term_id,
                term_value_id:  term_value_id,
                without_term_value_id: without_term_value_id,
                acc_below: acc_below,
                acc_below_or_unknown: acc_below_or_unknown,
                acc_above: acc_above,
                observed_before: observed_before,
                observed_on: observed_on,
                observed_after: observed_after,
                created_before: created_before,
                created_on: created_on,
                created_after: created_after,
                unobserved_by_user_id: unobserved_by_user_id,
                apply_project_rules_for: apply_project_rules_for,
                conservation_status: conservation_status,
                conservation_status_authority: conservation_status_authority,
                conservation_status_iucn: conservation_status_iucn,
                geoprivacy: geoprivacy,
                taxon_geoprivacy: taxon_geoprivacy,
                rank_lowest: rank_lowest,
                rank_highest: rank_highest,
                iconic_taxa: iconic_taxa,
                id_below: id_below,
                id_above: id_above,
                identifications: identifications,
                latitude: latitude,
                longitude: longitude,
                radius: radius,
                ne_latitude: ne_latitude,
                ne_longitude: ne_longitude,
                sw_latitude: sw_latitude,
                sw_longitude: sw_longitude,
                list_id: list_id,
                not_in_project: not_in_project,
                not_matching_project_rules_for: not_matching_project_rules_for,
                quality_grade: quality_grade,
                updated_since: updated_since,
                viewer_id: viewer_id,
                reviewed: reviewed,
                locale: locale,
                preferred_place_id: preferred_place_id,
                only_id: only_id,
                ttl: ttl,
                order: order,
                order_by: order_by,
                page: page,
                per_page: per_page,
                headers: headers,
                verbose: verbose).perform
  end

  # Taxon search
  # @param id [Array, String, nil] A taxon ID or comma-separated array of taxon IDs
  # @param q [String, nil] A search query
  # @param is_active [Boolean, nil]
  # @param taxon_id [Array, String, nil] Filter by a comma-separated array of taxon_ids
  # @param parent_id [Integer, nil] Filter by a taxon parent_id
  # @param rank [Array, String, nil] Filter by an array of taxon ranks
  # @param rank_level [Integer, nil] Filter by taxon rank level (e.g., 70 for kingdom)
  # @param id_above [Integer, nil] ID must be greater than value
  # @param id_below [Integer, nil] ID must be below value
  # @param preferred_place_id [Integer, nil] Place of preference for regional taxon common names
  # @param locale [String, nil] Locale preference for taxon common names (e.g., en-US)
  # @param only_id [Boolean, nil] Only return taxon_ids
  # @param all_names [Boolean, nil] Include all taxon names in the response
  #
  # @param order [String, nil] Ascending or descending sort order (asc, desc)
  # @param order_by [String, nil] The parameter to sort by
  # @param page [Integer, nil] The results page number
  # @param per_page [Integer, nil] The results limit
  # @param verbose [Boolean] Print headers to STDOUT
  #
  # @return [Array, Boolean] A hash with search results
  def self.taxa(id: nil, q: nil, is_active: nil, taxon_id: nil, parent_id: nil, rank: nil, rank_level: nil,
                id_above: nil, id_below: nil, locale: nil, only_id: nil, all_names: nil, preferred_place_id: nil,
                order: nil, order_by: nil, page: nil, per_page: nil, verbose: false)
    if id.nil?
      endpoint = 'taxa'
      Request.new(endpoint: endpoint, q: q, is_active: is_active, taxon_id: taxon_id, parent_id: parent_id, rank: rank,
                  rank_level: rank_level, id_above: id_above, id_below: id_below, locale: locale, only_id: only_id,
                  all_names: all_names, preferred_place_id: preferred_place_id, order: order, order_by: order_by,
                  page: page, per_page: per_page, verbose: verbose).perform
    else
      endpoint = "taxa/#{id}"
      Request.new(endpoint: endpoint, verbose: verbose).perform
    end
  end

  # Taxon suggest
  # @param q [String, nil] A suggest query
  # @param is_active [Boolean, nil] Suggest only active taxa
  # @param taxon_id [String, nil] Filter by comma-separated taxon IDs
  # @param rank [Array, String, nil] Filter by an array of taxon ranks
  # @param rank_level [Integer, nil] Filter by taxon rank level (e.g., 70 for kingdom)
  # @param locale [String, nil] Locale preference for taxon common names (e.g., en-US)
  # @param preferred_place_id [Integer, nil] Place of preference for regional taxon common names
  # @param all_names [Boolean, nil] Include all taxon names in the response
  #
  # @param per_page [Integer, nil] The results limit
  # @param verbose [Boolean] Print headers to STDOUT
  #
  # @return [Array, Boolean] A hash with search results
  def self.taxa_autocomplete(q: nil, is_active: nil, taxon_id: nil, rank: nil, rank_level: nil, locale: nil,
                             preferred_place_id: nil, all_names: nil, per_page: nil, verbose: false)
    endpoint = 'taxa/autocomplete'
    Request.new(endpoint: endpoint, q: q, is_active: is_active, taxon_id: taxon_id, rank: rank, rank_level: rank_level,
                locale: locale, preferred_place_id: preferred_place_id, all_names: all_names, per_page: per_page,
                verbose: verbose).perform
  end
end
