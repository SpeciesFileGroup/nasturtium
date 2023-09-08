require_relative "test_helper"

class TestApiToken < Test::Unit::TestCase

  def test_api_token
    VCR.use_cassette("test_api_token") do
      res = Inaturalia.api_token("", "")
      puts res
    end
  end
end