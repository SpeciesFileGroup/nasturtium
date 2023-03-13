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
  # @param q [String] A search query
  # @param sources [Array, String, nil] Type of record to search (places, projects, taxa, users)
  # @param place_id [String, nil] Filter to an array of place_ids (TODO: place_id is an array in the documentation but doesn't seem to work even with their example?)
  # @param preferred_place_id [Integer, nil] Place of preferrence for regional taxon common names  # TODO: removed because doesn't do anything?
  # @param locale [String, nil] Locale preference for taxon common names (e.g., en-US)
  #
  # @param page [Integer, nil] The results page number
  # @param per_page [Integer, nil] The results limit
  # @param verbose [Boolean] Print headers to STDOUT
  #
  # @return [Array, Boolean] An array of hashes
  def self.search(q, sources: nil, place_id: nil, locale: nil, page: nil, per_page: nil,
                  verbose: false)
    endpoint = 'search'
    Request.new(
      endpoint: endpoint,
      q: q,
      sources: sources,
      place_id: place_id,
      locale: locale,
      page: page,
      per_page: per_page,
      verbose: verbose
    ).perform
  end

end
