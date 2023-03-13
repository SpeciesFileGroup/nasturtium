# require "faraday"
# require "faraday_middleware"
# require "multi_json"

##
# Inaturalia::RequestCursor
#
## Class to perform HTTP requests to the iNaturalist API
module Inaturalia
  class RequestCursor
    attr_accessor :endpoint
    attr_accessor :engine
    attr_accessor :q

    def initialize(endpoint, engine, q)
    end
  end
end
