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
      @locale = args[:locale]

      @page = args[:page]
      @per_page = args[:per_page]
      @options = args[:options] # TODO: not added at inaturalia.rb
    end

    # TODO: arrays are done like this source[]=users,projects but sometime without the brackets?
    def perform

      args = {
        q: @q,
        sources: @sources,
        place_id: @place_id,
        locale: @locale,
        page: @page,
        per_page: @per_page
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
