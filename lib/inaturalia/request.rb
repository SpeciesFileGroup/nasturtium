require_relative "faraday" # !! Potential ruby 3.0 difference in module loading? relative differs from Serrano
require "faraday_middleware"
require_relative "utils"

module Inaturalia

  class Request
    attr_accessor :endpoint
    attr_accessor :q
    attr_accessor :verbose

    attr_accessor :options

    def initialize(**args)
      @endpoint = args[:endpoint]
      @verbose = args[:verbose]
      @q = args[:q]
      @sources = args[:sources]
      @place_id = args[:place_id]
      @preferred_place_id = args[:preferred_place_id]
      @locale = args[:locale]
      @is_active = args[:is_active]
      @taxon_id = args[:taxon_id]
      @parent_id = args[:parent_id]
      @rank = args[:rank]
      @rank_level = args[:rank_level]
      @id_above = args[:id_above]
      @id_below = args[:id_below]
      @only_id = args[:only_id]
      @all_names = args[:all_names]

      @page = args[:page]
      @per_page = args[:per_page]
      @order = args[:order]
      @order_by = args[:order_by]
      @options = args[:options] # TODO: not added at inaturalia.rb
    end

    # TODO: arrays are done like this source[]=users,projects but sometime without the brackets?
    def perform

      args = {
        q: @q,
        sources: @sources,
        place_id: @place_id,
        preferred_place_id: @preferred_place_id,
        is_active: @is_active,
        taxon_id: @taxon_id,
        parent_id: @parent_id,
        rank: @rank,
        rank_level: @rank_level,
        id_above: @id_above,
        id_below: @id_below,
        only_id: @only_id,
        all_names: @all_names,
        locale: @locale,
        page: @page,
        per_page: @per_page,
        order: @order,
        order_by: @order_by
      }
      opts = args.delete_if { |_k, v| v.nil? }

      Faraday::Utils.default_space_encoding = "+"

      conn = if verbose
               Faraday.new(url: Inaturalia.base_url) do |f|
                 f.response :logger
                 f.use FaradayMiddleware::RaiseHttpException
                 f.adapter Faraday.default_adapter
               end
             else
               Faraday.new(url: Inaturalia.base_url) do |f|
                 f.use FaradayMiddleware::RaiseHttpException
                 f.adapter Faraday.default_adapter
               end
             end

      conn.headers['Accept'] = 'application/json,*/*'
      conn.headers[:user_agent] = make_user_agent
      conn.headers["X-USER-AGENT"] = make_user_agent

      res = conn.get(endpoint, opts)

      # Handles endpoints that do not return JSON
      begin
        MultiJson.load(res.body)
      rescue MultiJson::ParseError
        res.body
      end
      
    end
  end
end
