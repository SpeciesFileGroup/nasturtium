# frozen_string_literal: true

require "erb"
require 'open-uri'
require_relative "nasturtium/error"
require_relative "nasturtium/version"
require_relative "nasturtium/request"
require "nasturtium/helpers/configuration"
require 'cgi'

module Nasturtium
  extend Configuration

  define_setting :base_url, "https://api.inaturalist.org/v1/"
  define_setting :mailto, ENV["NASTURTIUM_API_EMAIL"]

  # Get API token
  # @param user [String]
  # @param password [String]
  # def self.api_token(user, password, verbose: false)
  #   doc = Nokogiri::HTML(URI.open('https://www.inaturalist.org/users/api_token'))
  #   csrf_token = CGI.escape(doc.at('meta[name="csrf-token"]')['content'])

  #   puts csrf_token
  #   # https://www.inaturalist.org/users/api_token
  #   body = "utf8=%E2%9C%93&authenticity_token=#{csrf_token}&user%5Bemail%5D=#{user}&user%5Bpassword%5D=#{password}&user%5Bremember_me%5D=0"
  #   endpoint = 'users/api_token'
  #   res = Request.new(method: 'POST', base_url: 'https://www.inaturalist.org/', endpoint: endpoint, body: body, verbose: verbose).perform
  #   puts res
  # end

  # Get controlled vocabulary terms
  # @param taxon_id [String, nil] If set returns controlled terms for the taxon
  #
  # @param page [Integer, nil] The results page number
  # @param per_page [Integer, nil] The results limit
  # @param verbose [Boolean] Print headers to STDOUT
  #
  # @return [Hash, Boolean] A hash of controlled terms results
  def self.controlled_terms(taxon_id: nil, page: nil, per_page: nil, verbose: false)
    if taxon_id.nil?
      endpoint = 'controlled_terms'
    else
      endpoint = 'controlled_terms/for_taxon'
    end
    Request.new(endpoint: endpoint, taxon_id: taxon_id, page: page, per_page: per_page, verbose: verbose).perform
  end

  # Get identifications
  # @param id [String, Integer, nil] An array of identification IDs
  # @param current_taxon [Boolean, nil] The identification taxon is the same as its observation's taxon
  # @param own_observation [Boolean, nil] The identification was added by th observer
  # @param is_change [Boolean, nil] The identification was created as a result of a taxon change
  # @param taxon_active [Boolean nil] The identification's taxon is currently an active taxon
  # @param observation_taxon_active [Boolean, nil] The observation's taxon is currently an active taxon
  # @param rank [String, nil] Filter by a comma-separated list of taxonomic ranks on the identification
  # @param observation_rank [String, nil] Filter by a comma-separated list of taxonomic ranks on the observation
  # @param user_id [String, Integer, nil] Filter by a comma-separated list of user IDs
  # @param user_login [String, nil] Filter by a comma-separated list of user logins
  # @param current [Boolean, nil] The most recent identification on an observation by a user
  # @param category [String, nil] The type of identification (improving, supporting, leading)
  # @param place_id [String, Integer, nil] Filter by a comma-separated list of place IDs
  # @param quality_grade [String, nil] Filter by a comma-separated list of quality grades (casual, needs_id, research)
  # @param taxon_id [String, Integer, nil] Filter by a comma-separated list of taxon IDs on the identification
  # @param observation_taxon_id [String, Integer, nil] Filter by a comma-separated list of taxon IDs on the observation
  # @param iconic_taxon_id [String, Integer, nil] Filter by a comma-separated list of iconic taxon IDs on the identification
  # @param observation_iconic_taxon_id [String, Integer, nil] Filter by a comma-separated list of iconic taxon IDs on the observation
  # @param rank_lowest [String, nil] The identification's taxon must have this rank or higher
  # @param rank_highest [String, nil] The identification's taxon must have this rank or lower
  # @param observation_rank_lowest [String, nil] The observation's taxon must have this rank or higher
  # @param observation_rank_highest [String, nil] The observation's taxon must have this rank or lower
  # @param without_taxon_id [String, Integer, nil] Exclude this comma-separated list of identification taxon IDs and their descendants
  # @param without_observation_taxon_id [String, Integer, nil] Exclude this comma-separated list of observation taxon IDs and their descendants
  # @param before [String, nil] Identified before this time (d2)
  # @param after [String, nil] Identified after this time (d1)
  # @param observation_created_before [String, nil] Observation record was created before this time (observation_created_d2)
  # @param observation_created_after [String, nil] Observation record was created after this time (observation_created_d1)
  # @param observed_before [String, nil] Observed before this time (observed_d2)
  # @param observed_after [String, nil] Observed after this time (observed_d1)
  # @param id_below [String, Integer, nil] The identification ID must be below the provided value
  # @param id_above [String, Integer, nil] The identification ID must be above the provided value
  # @param only_id [Boolean, nil] Only return record IDs
  #
  # @param order [String, nil] Ascending or descending sort order (asc, desc)
  # @param order_by [String, nil] The parameter to sort by (created_at, id)
  # @param page [Integer, nil] The results page number
  # @param per_page [Integer, nil] The results limit
  # @param verbose [Boolean] Print headers to STDOUT
  #
  # @return [Hash, Boolean] A hash of identification results
  def self.identifications(id: nil, current_taxon: nil, own_observation: nil, is_change: nil,
                           taxon_active: nil, observation_taxon_active: nil, rank: nil, observation_rank: nil,
                           user_id: nil, user_login: nil, current: nil, category: nil, place_id: nil,
                           quality_grade: nil, taxon_id: nil, observation_taxon_id: nil, iconic_taxon_id: nil,
                           observation_iconic_taxon_id: nil, rank_lowest: nil, rank_highest: nil,
                           observation_rank_lowest: nil, observation_rank_highest: nil, without_taxon_id: nil,
                           without_observation_taxon_id: nil, before: nil, after: nil,
                           observation_created_before: nil, observation_created_after: nil, observed_before: nil,
                           observed_after: nil, id_below: nil, id_above: nil, only_id: nil, order: nil, order_by: nil,
                           page: nil, per_page: nil, verbose: false)
    endpoint = 'identifications'
    Request.new(endpoint: endpoint,
                id: id,
                current_taxon: current_taxon,
                own_observation: own_observation,
                is_change: is_change,
                taxon_active: taxon_active,
                observation_taxon_active: observation_taxon_active,
                rank: rank,
                observation_rank: observation_rank,
                user_id: user_id,
                user_login: user_login,
                current: current,
                category: category,
                place_id: place_id,
                quality_grade: quality_grade,
                taxon_id: taxon_id,
                observation_taxon_id: observation_taxon_id,
                iconic_taxon_id: iconic_taxon_id,
                observation_iconic_taxon_id: observation_iconic_taxon_id,
                rank_lowest: rank_lowest,
                rank_highest: rank_highest,
                observation_rank_lowest: observation_rank_lowest,
                observation_rank_highest: observation_rank_highest,
                without_taxon_id: without_taxon_id,
                without_observation_taxon_id: without_observation_taxon_id,
                before: before,
                after: after,
                observation_created_before: observation_created_before,
                observation_created_after: observation_created_after,
                observed_before: observed_before,
                observed_after: observed_after,
                id_below: id_below,
                id_above: id_above,
                only_id: only_id,
                order: order,
                order_by: order_by,
                page: page,
                per_page: per_page,
                verbose: verbose).perform
  end

  # Get map tiling assets for observations
  # 
  # Mapping-specific parameters:
  #   @param asset_type [String] The type of asset to return [colored_heatmap, grid, heatmap, points, places, taxon_places, taxon_ranges]
  #   @param return_json [Boolean] Whether to return UTFGRid (only use with asset_types: colored_heatmap, grid, heatmap, points)
  #   @param color [String, nil] A color to use in map creation (e.g., blue, #0000ff)
  #   @param style [String, nil] The map tile style (geotilegrid, possibly others)
  #   @param tile_size [Integer, nil] The map tile size in pixels
  #
  # All of the parameters for filtering observations are also available:
  #   @param q [String, nil] An observation properties search query
  #   @param search_on [String, nil] Observation properties to search on (names, tags, description, place)
  #   @param id [String, Integer, nil] A comma-separated list of observation IDs
  #   @param not_id [String, Integer, nil] A comma-separated list of observation IDs that must not be included
  #   @param acc [Boolean, nil] Filter by whether the positional accuracy/coordinate uncertainty was specified
  #   @param captive [Boolean, nil] Filter on whether it was captive/cultivated observations
  #   @param endemic [Boolean, nil] Filter on whether observations were of taxa endemic to their location
  #   @param geo [Boolean, nil] Filter to only georeferenced observations
  #   @param identified [Boolean, nil] Filter to only observations with community identifications
  #   @param introduced [Boolean, nil] Filter to observations of taxa that were introduced to their location
  #   @param mappable [Boolean, nil] Filter to only observations that show on map tiles
  #   @param native [Boolean, nil] Filter to only observations of taxa native tot heir location
  #   @param out_of_range [Boolean, nil] Filter to only observations made in locations outside the taxon's known ranges
  #   @param pcid [Boolean, nil] Filter to observations identified by a curator of a project
  #   @param photos [Boolean, nil] Filter to observations with photos
  #   @param popular [Boolean, nil] Filter to only observations that have been favorited by at least 1 user
  #   @param sounds [Boolean, nil] Filter to observations with sounds
  #   @param taxon_is_active [Boolean, nil] Filter to observations of active taxon concepts
  #   @param threatened [Boolean, nil] Filter to observations of taxa that are threatened at their location
  #   @param verifiable [Boolean, nil] Filter by observations with a quality_grade=needs_id,research
  #   @param licensed [Boolean, nil] Filter by observations with a license
  #   @param photo_licensed [Boolean, nil] License attribute of at least one photo in an observation must not be nil
  #   @param license [String, nil] Filter by a comma-separated list of licenses (cc-by,cc-by-nc,cc-by-nd,cc-by-sa,cc-by-nc-nd,cc-by-nc-sa,cc0)
  #   @param photo_license [String, nil] Filter by a comma-separated list of photo licenses (cc-by,cc-by-nc,cc-by-nd,cc-by-sa,cc-by-nc-nd,cc-by-nc-sa,cc0)
  #   @param sound_license [String, nil] Filter by a comma-separated list of sound licenses (cc-by,cc-by-nc,cc-by-nd,cc-by-sa,cc-by-nc-nd,cc-by-nc-sa,cc0)
  #   @param ofv_datatype [String, nil] Filter by a comma-separated list of datatypes that the observation must include  # TODO: does it take arrays?
  #   @param place_id [String, Integer, nil] Filter by a comma-separated list of place_ids
  #   @param project_id [String, Integer, nil] Filter by a comma-separated list of project_ids
  #   @param rank [String, nil] Filter by an array of taxon ranks
  #   @param site_id [String, Integer, nil] Filter by a comma-separated list of site_ids
  #   @param taxon_id [String, Integer, nil] Filter by a comma-separated list of taxon_ids and their descendants
  #   @param without_taxon_id [String, Integer, nil] Exclude a comma-separated list of taxon_ids and their descendants
  #   @param taxon_name [String, Integer, nil] Filter by a comma-separated list of scientific or common names
  #   @param user_id [String, Integer nil] Filter by observations made by a comma-separated list of user_ids
  #   @param user_login [String, nil] Filter by a comma-separated list of user_logins
  #   @param ident_user_id [String, Integer, nil] Filter by observations identified by a particular user_id
  #   @param day [String, Integer, nil] Filter on a comma-separated list of days
  #   @param month [String, Integer, nil] Filter on a comma-separated list of months
  #   @param year [String, Integer, nil] Filter on a comma-separated list of years
  #   @param term_id [String, Integer, nil] Filter on a comma-separated list of term_ids
  #   @param without_term_id String, Integer, nil] Exclude on a comma-separated list of term_ids
  #   @param term_value_id [String, Integer, nil] Filter on annotations made with this controlled value ID; must be used with term_id
  #   @param without_term_value_id [String, Integer, nil] Exclude on annotations made with this controlled value ID
  #   @param acc_above [String, nil] Positional accuracy must be above value
  #   @param acc_below [String, nil] Positional accuracy must be below value
  #   @param acc_below_or_unknown [String, nil] Positional accuracy must be below value or unknown
  #   @param before [String, nil] Must have been observed on or before this date (d2)
  #   @param after [String, nil] Must have been observed on or after this date (d1)
  #   @param observed_on [String, nil] Must have been observed on this date
  #   @param created_before [String, nil] Must have been created on or before this date (created_d2)
  #   @param created_on [String, nil] Must have been created on this date
  #   @param created_after [String, nil] Must have been created on or before this date (created_d1)
  #   @param unobserved_by_user_id [String, nil] Taxon must be unobserved by the provided user_id
  #   @param apply_project_rules_for [String, nil] Must match rules of the provided project_id
  #   @param conservation_status [String, nil] Taxon must have this conservation status (cs) code, use with place_id to make location-specific
  #   @param conservation_status_authority [String, nil] Taxon must have the conservation status from the provided authority (csa), use with place_id to make location-specific
  #   @param conservation_status_iucn [String, nil] Taxon must have the provided conservation status from the IUCN, use with place_id to make location-specific
  #   @param geoprivacy [String, nil] Filter by a comma-separated list of geoprivacy settings (obscured, obscured_private, open)
  #   @param taxon_geoprivacy [String, nil] Filter by a comma-separated list of geoprivacy settings (obscured, obscured_private, open) of the most conservative geoprivacy associated with one of the taxa proposed in the current identifications
  #   @param rank_lowest [String, nil] Taxon rank must be less than or equal to provided rank
  #   @param rank_highest [String, nil] Taxon rank must be greater than or equal to provided rank
  #   @param iconic_taxa [String, nil] Filter by taxa with the provided iconic taxon (Actinopterygii, Animalia, Amphibia, Arachnida, Aves, Chromista, Fungi, Insecta, Mammalia, Mollusca, Repitilia, Plantae, Protozoa, unknown)
  #   @param id_below [String, Integer, nil] Most have an observation ID below the provided value
  #   @param id_above [String, Integer, nil] Most have an observation ID above the provided value
  #   @param identifications [String, nil] Filter by identifications status (most_agree, some_agree, most_disagree)
  #   @param latitude [Double, nil] Filter by observations within a {radius} kilometer circle around the provided latitude coordinate (lat)
  #   @param longitude [Double, nil] Filter by observations within a {radius} kilometer circle around the provided longitude coordinate (lng)
  #   @param radius [String, Integer, Double] Filter by observations within the provided radius in kilometers
  #   @param ne_latitude [Double, nil] Filter by observations within provided (nelat) bounding box (ne_latitude, ne_longitude, sw_latitude, sw_longitude)
  #   @param ne_longitude [Double, nil] Filter by observations within provided (nelng) bounding box (ne_latitude, ne_longitude, sw_latitude, sw_longitude)
  #   @param sw_latitude [Double, nil] Filter by observations within provided (swlat) bounding box (ne_latitude, ne_longitude, sw_latitude, sw_longitude)
  #   @param sw_longitude [Double, nil] Filter by observations within provided (swlng) bounding box (ne_latitude, ne_longitude, sw_latitude, sw_longitude)
  #   @param list_id [Integer, nil] Taxon must bin the list with the provided ID
  #   @param not_in_project [String, nil] Observation must not be in the provided project_id or slug
  #   @param not_matching_project_rules_for [String, nil] Must not match the rules of the provided project_id or slug
  #   @param quality_grade [String, nil] Filter by observation quality grade (casual, needs_id, research)
  #   @param updated_since [String, nil] Filter by observations updated since the provided time
  #   @param reviewed [Boolean, nil] Observations have been reviewed by viewer_id
  #   @param viewer_id [String, nil] Use with reviewed boolean to filter by observations reviewed by the provided viewer_id
  #   @param locale [String, nil] Locale preference for taxon common names (e.g., en-US)
  #   @param preferred_place_id [Integer, nil] Place of preference for regional taxon common names
  #   @param ttl [String, Integer, nil] Set the Cache-Control HTTP header with a max-age value to cache the request on iNaturalist serers and within the client
  #   @param only_id [Boolean, nil] Only return record IDs
  #
  # @return [Binary, Hash] Returns binary png images of map tiles unless return_json is true
  def self.mapping(asset_type, zoom_level, x, y, return_json: false, color: nil, style: nil, tile_size: nil, 
    q: nil, search_on: nil, id: nil, not_id: nil, acc: nil, captive: nil,
    endemic: nil, geo: nil, identified: nil, introduced: nil, mappable: nil, native: nil,
    out_of_range: nil, pcid: nil, photos: nil, popular: nil, sounds: nil, taxon_is_active: nil,
    threatened: nil, verifiable: nil, licensed: nil, photo_licensed: nil,
    photo_license: nil, sound_license: nil, ofv_datatype: nil, place_id: nil, project_id: nil,
    rank: nil, site_id: nil, taxon_id: nil, without_taxon_id: nil, taxon_name: nil, user_id: nil,
    user_login: nil, ident_user_id: nil, day: nil, month: nil, year: nil, term_id: nil,
    without_term_id: nil, term_value_id: nil, without_term_value_id: nil, acc_below: nil,
    acc_below_or_unknown: nil, acc_above: nil, before: nil, observed_on: nil,
    after: nil, created_before: nil, created_on: nil, created_after: nil,
    unobserved_by_user_id: nil, apply_project_rules_for: nil, conservation_status: nil,
    conservation_status_authority: nil, conservation_status_iucn: nil, geoprivacy: nil,
    taxon_geoprivacy: nil, rank_lowest: nil, rank_highest: nil, iconic_taxa: nil,
    id_below: nil, id_above: nil, identifications: nil, latitude: nil, longitude: nil,
    radius: nil, ne_latitude: nil, ne_longitude: nil, sw_latitude: nil, sw_longitude: nil,
    list_id: nil, not_in_project: nil, not_matching_project_rules_for: nil, quality_grade: nil,
    updated_since: nil, viewer_id: nil, reviewed: nil, locale: nil, preferred_place_id: nil,
    only_id: nil, ttl: nil, order: nil, order_by: nil, page: nil, per_page: nil, headers: false,
    verbose: false)

    if !color.nil? and color.include? '#'
      color = color.gsub('#', '%23')
    end

    endpoint = ''
    if ['colored_heatmap', 'grid', 'heatmap', 'points'].include? asset_type
      if return_json
        endpoint = "#{asset_type}/#{zoom_level}/#{x}/#{y}.grid.json"
      else
        endpoint = "#{asset_type}/#{zoom_level}/#{x}/#{y}.png"
      end
    elsif asset_type == 'places'
      endpoint = "places/#{place_id}/#{zoom_level}/#{x}/#{y}.png"
      if place_id.nil?
        raise "place_id must be provided"
      end
    elsif asset_type == 'taxon_places'
      endpoint = "taxon_places/#{taxon_id}/#{zoom_level}/#{x}/#{y}.png"
      if taxon_id.nil?
        raise "taxon_id must be provided"
      end
    elsif asset_type == 'taxon_ranges'
      endpoint = "taxon_ranges/#{taxon_id}/#{zoom_level}/#{x}/#{y}.png"
      if taxon_id.nil?
        raise "taxon_id must be provided"
      end
    else
      raise "Invalid asset_type: #{asset_type} (must be one of: colored_heatmap, grid, heatmap, points, places, taxon_places, taxon_ranges)" 
    end

    Request.new(endpoint: endpoint,
      color: color,
      style: style,
      tile_size: tile_size,
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
      before: before,
      observed_on: observed_on,
      after: after,
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


  # Get places
  # @param id [String, Integer] A comma-separated list of place IDs
  # @param admin_level [String, Integer, nil] A comma-separated list of admin levels (-10: continent, 0: country, 10: state, 20: county, 30: town, 100: park)
  #
  # @return [Hash, Boolean] A hash with places results
  def self.places_id(id, admin_level: nil, verbose: false)
    endpoint = "places/#{id}"
    Request.new(endpoint: endpoint, admin_level: admin_level, verbose: verbose).perform
  end

  # Suggest places
  # @param q [String] A place name must start with this query
  #
  # @param order_by [String, nil] The parameter to sort by (area)  # TODO: iNaturalist bug? doesn't seem to affect sorting in the API?
  # @param per_page [Integer, nil] The results limit
  # @param verbose [Boolean] Print headers to STDOUT
  #
  # @return [Hash, Boolean] A hash with suggest places results
  def self.places_autocomplete(q, order_by: nil, per_page: nil, verbose: false)
    endpoint = "places/autocomplete"
    Request.new(endpoint: endpoint, q: q, order_by: order_by, per_page: per_page, verbose: verbose).perform
  end

  # https://api.inaturalist.org/v1/places/nearby?nelat=40.346036&nelng=-87.951568&swlat=39.935393&swlng=-88.628846
  # Get nearby places
  # @param ne_latitude [Double, nil] Get nearby places within provided (nelat) bounding box (ne_latitude, ne_longitude, sw_latitude, sw_longitude)
  # @param ne_longitude [Double, nil] Get nearby places within provided (nelng) bounding box (ne_latitude, ne_longitude, sw_latitude, sw_longitude)
  # @param sw_latitude [Double, nil] Get nearby places within provided (swlat) bounding box (ne_latitude, ne_longitude, sw_latitude, sw_longitude)
  # @param sw_longitude [Double, nil] Get nearby places within provided (swlng) bounding box (ne_latitude, ne_longitude, sw_latitude, sw_longitude)
  # @param name [String, nil] Place name must match this value  # TODO: iNaturalist bug? you can't provide the last word of a name (e.g., River Bend Forest works, but River Bend Forest Preserve doesn't work)
  #
  # @param per_page [Integer, nil] The results limit
  # @param verbose [Boolean] Print headers to STDOUT
  #
  # @return [Hash, Boolean] A hash with suggest places results
  def self.places_nearby(ne_latitude, ne_longitude, sw_latitude, sw_longitude, name: nil, verbose: false)
    endpoint = "places/nearby"
    Request.new(endpoint: endpoint, ne_latitude: ne_latitude, ne_longitude: ne_longitude, sw_latitude: sw_latitude, sw_longitude: sw_longitude, name: name, verbose: verbose).perform
  end


  # Get journal posts
  # @param login [String, nil] Filter by user login
  # @param project_id [String, Integer, nil] Filter by project ID
  # @param parent_id [String, Integer, nil] Filter by parent ID
  #
  # @param page [String, Integer, nil] 
  # @param per_page [String, Integer, nil]
  # @param verbose [Boolean] Print headers to STDOUT
  #
  # @return [Array, Boolean] An array of journal posts
  def self.posts(login: nil, project_id: nil, parent_id: nil, page: nil, per_page: nil, verbose: false)
    endpoint = "posts"
    Request.new(endpoint: endpoint, login: login, project_id: project_id, parent_id: parent_id, page: page, per_page: per_page, verbose: verbose).perform
  end

  # TODO: Add tests
  # Get projects
  # @param q [String, nil] Project name must begin with query string
  # @param autocomplete [Boolean, nil] Returns projects that start with the search q
  # @param id [String, Integer, nil] Project must have this ID
  # @param not_id [String, Integer, nil] Project must not have this ID
  # @param latitude [Double, nil] Filter by projects within a {radius} kilometer circle around the provided latitude coordinate (lat)
  # @param longitude [Double, nil] Filter by projects within a {radius} kilometer circle around the provided longitude coordinate (lng)
  # @param radius [String, Integer, Double] Filter by projects within the provided radius in kilometers
  # @param place_id [String, Integer, nil] Filter by a comma-separated list of place_ids
  # @param featured [Boolean, nil] Filter by marked featured for the relevant site
  # @param noteworthy [Boolean, nil] Filter by marked noteworthy for the relevant site
  # @param site_id [String, Integer, nil] The site ID that applies to featured and noteworthy, defaults to site of the authenticated user or the main iNaturalist site
  # @param rule_details [Boolean, nil] Return more details about the project rules
  # @param type [String, nil] Filter by project type [collection, umbrella]
  # @param member_id [String, Integer, nil] Filter by projects that include a user ID
  # @param has_params [Boolean, nil] Must have search parameter requirements
  # @param has_posts [Boolean, nil] Project must have posts
  #
  # @param page [Integer, nil] The results page number
  # @param per_page [Integer, nil] The results limit
  # @param order_by [String, nil] The parameter to sort by (observed_on, species_guess, votes, id, created_at)
  # @param verbose [Boolean] Print headers to STDOUT
  #
  # @return [Hash, Boolean] A hash with search results
  def self.projects(q: nil, autocomplete: nil, id: nil, not_id: nil, latitude: nil, longitude: nil, radius: nil, place_id: nil, featured: nil, noteworthy: nil, site_id: nil, rule_details: nil, type: nil, member_id: nil, has_params: nil, has_posts: nil, page: nil, per_page: nil, order_by: nil, verbose: false)
    if autocomplete
      endpoint = "projects/autocomplete"
    else
      endpoint = "projects"
    end
    Request.new(endpoint: endpoint, q: q, id: id, not_id: not_id, latitude: latitude, longitude: longitude, radius: radius, place_id: place_id, featured: featured, noteworthy: noteworthy, site_id: site_id, rule_details: rule_details, type: type, member_id: member_id, has_params: has_params, has_posts: has_posts, page: page, per_page: per_page, order_by: order_by, verbose: verbose).perform
  end

  # Get project members
  # @param id [String, Integer] The project ID
  #
  # @param page [Integer, nil] The results page number
  # @param per_page [Integer, nil] The results limit
  # @param verbose [Boolean] Print headers to STDOUT
  #
  # @return [Hash, Boolean] A hash with search results
  def self.project_members(id, page: nil, per_page: nil, verbose: false)
    endpoint = "projects/#{id}/members"
    Request.new(endpoint: endpoint, page: page, per_page: per_page, verbose: verbose).perform
  end

  # Search places, projects, taxa, users
  # @param q [String, nil] A search query
  # @param sources [String, nil] Type of record to search (places, projects, taxa, users)
  # @param place_id [String, nil] Filter to an array of place_ids (TODO: place_id is an array in the documentation but doesn't seem to work even with their example?)
  # @param preferred_place_id [Integer, nil] Place of preference for regional taxon common names
  # @param locale [String, nil] Locale preference for taxon common names (e.g., en-US)
  #
  # @param page [Integer, nil] The results page number
  # @param per_page [Integer, nil] The results limit
  # @param verbose [Boolean] Print headers to STDOUT
  #
  # @return [Hash, Boolean] A hash with search results
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

  # Get user
  # @param id [Integer] The user ID
  #
  # @param verbose [Boolean] Print headers to STDOUT
  #
  # @return [Hash, Boolean] A hash with user results
  def self.user(id, verbose: false)
    endpoint = "users/#{id}"
    Request.new(endpoint: endpoint, verbose: verbose).perform
  end

  # Get logged in user
  # @param id [Integer] The user ID
  #
  # @param verbose [Boolean] Print headers to STDOUT
  #
  # @return [Hash, Boolean] A hash with user results
  def self.user_me(verbose: false)
    endpoint = "users/me"
    Request.new(endpoint: endpoint, verbose: verbose).perform
  end

  # Get user's projects
  # @param id [Integer] The user ID
  # @param rule_details [Boolean, nil] Return more details about project rules
  # @param project_type [String, nil] Filter by project type (collection, contest, traditional, umbrella)
  #
  # @param page [Integer, nil] The results page number
  # @param per_page [Integer, nil] The results limit
  # @param verbose [Boolean] Print headers to STDOUT
  #
  # @return [Hash, Boolean] A hash with user results
  def self.user_projects(id, rule_details: nil, project_type: nil, page: nil, per_page: nil, verbose: false)
    endpoint = "users/#{id}/projects"
    Request.new(endpoint: endpoint, rule_details: rule_details, project_type: project_type,
                page: page, per_page: per_page, verbose: verbose).perform
  end

  # Get user suggestions
  # @param q [String] The username must begin with this query
  # @param project_id [Integer, nil] Only show members of this project ID
  #
  # @param per_page [Integer, nil] The results limit
  # @param verbose [Boolean] Print headers to STDOUT
  #
  # @return [Hash, Boolean] A hash with user results
  def self.user_autocomplete(q, project_id: nil, per_page: nil, verbose: false)
    endpoint = "users/autocomplete"
    Request.new(endpoint: endpoint, q: q, project_id: project_id, per_page: per_page, verbose: verbose).perform
  end

  # TODO: iNatualist API documentation does not include sound_license?

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
  # @param ident_user_id [String, Integer, nil] Filter by observations identified by a particular user_id
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
  # @param before [String, nil] Must have been observed on or before this date (d2)
  # @param after [String, nil] Must have been observed on or after this date (d1)
  # @param observed_on [String, nil] Must have been observed on this date
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
                        acc_below_or_unknown: nil, acc_above: nil, before: nil, observed_on: nil,
                        after: nil, created_before: nil, created_on: nil, created_after: nil,
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
                before: before,
                observed_on: observed_on,
                after: after,
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
  # @param id [String, Integer, nil] A taxon ID or comma-separated array of taxon IDs
  # @param q [String, nil] A search query
  # @param is_active [Boolean, nil] Filter to taxa with active taxon concepts
  # @param taxon_id [String, Integer, nil] Filter by a comma-separated array of taxon_ids
  # @param parent_id [Integer, nil] Filter by a taxon parent_id
  # @param rank [String, nil] Filter by an array of taxon ranks
  # @param rank_level [Integer, nil] Filter by taxon rank level (e.g., 70 for kingdom)
  # @param id_above [Integer, nil] ID must be greater than value
  # @param id_below [Integer, nil] ID must be below value
  # @param preferred_place_id [Integer, nil] Place of preference for regional taxon common names
  # @param locale [String, nil] Locale preference for taxon common names (e.g., en-US)
  # @param only_id [Boolean, nil] Only return record IDs
  # @param all_names [Boolean, nil] Include all taxon names in the response
  #
  # @param order [String, nil] Ascending or descending sort order (asc, desc)
  # @param order_by [String, nil] The parameter to sort by
  # @param page [Integer, nil] The results page number
  # @param per_page [Integer, nil] The results limit
  # @param verbose [Boolean] Print headers to STDOUT
  #
  # @return [Hash, Boolean] A hash with search results
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
  # @param is_active [Boolean, nil] Suggest only taxa with active taxon concepts
  # @param taxon_id [String, nil] Filter by comma-separated taxon IDs
  # @param rank [String, nil] Filter by an array of taxon ranks
  # @param rank_level [Integer, nil] Filter by taxon rank level (e.g., 70 for kingdom)
  # @param locale [String, nil] Locale preference for taxon common names (e.g., en-US)
  # @param preferred_place_id [Integer, nil] Place of preference for regional taxon common names
  # @param all_names [Boolean, nil] Include all taxon names in the response
  #
  # @param per_page [Integer, nil] The results limit
  # @param verbose [Boolean] Print headers to STDOUT
  #
  # @return [Hash, Boolean] A hash with search results
  def self.taxa_autocomplete(q: nil, is_active: nil, taxon_id: nil, rank: nil, rank_level: nil, locale: nil,
                             preferred_place_id: nil, all_names: nil, per_page: nil, verbose: false)
    endpoint = 'taxa/autocomplete'
    Request.new(endpoint: endpoint, q: q, is_active: is_active, taxon_id: taxon_id, rank: rank, rank_level: rank_level,
                locale: locale, preferred_place_id: preferred_place_id, all_names: all_names, per_page: per_page,
                verbose: verbose).perform
  end
end
