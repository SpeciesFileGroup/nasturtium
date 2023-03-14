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
