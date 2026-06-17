# frozen_string_literal: true

require "faraday"
require "multi_json"

# @private
module Faraday
  module NasturtiumErrors
  # @private
    class Middleware < Faraday::Middleware
      def call(env)
        @app.call(env).on_complete do |response|
          case response[:status].to_i
          when 400
            raise Nasturtium::BadRequest, error_message_400(response)
          when 404
            raise Nasturtium::NotFound, error_message_400(response)
          when 500
            raise Nasturtium::InternalServerError, error_message_500(response, "Something is technically wrong.")
          when 502
            raise Nasturtium::BadGateway, error_message_500(response, "The server returned an invalid or incomplete response.")
          when 503
            raise Nasturtium::ServiceUnavailable, error_message_500(response, "Crossref is rate limiting your requests.")
          when 504
            raise Nasturtium::GatewayTimeout, error_message_500(response, "504 Gateway Time-out")
          end
        end
      end
    

      def initialize(app)
        super app
        @parser = nil
      end

      private

      def error_message_400(response)
        "\n   #{response[:method].to_s.upcase} #{response[:url]}\n   Status #{response[:status]}#{error_body(response[:body])}"
      end

      def error_body(body)
        return nil if body.nil? || !body.is_a?(String) || body.empty?
        return ": #{body}" unless json?(body)

        parsed = ::MultiJson.load(body)
        msg = parsed["message"] || parsed["error"]
        return nil if msg.nil?

        msg = msg.collect { |x| x.is_a?(Hash) ? x["message"] : x.to_s }.join("; ") if msg.is_a?(Array)
        ": #{msg}"
      end

      def error_message_500(response, body = nil)
        "#{response[:method].to_s.upcase} #{response[:url]}: #{[response[:status].to_s + ":", body].compact.join(" ")}"
      end

      def json?(string)
        MultiJson.load(string)
        true
      rescue MultiJson::ParseError
        false
      end
    end
  end
end
