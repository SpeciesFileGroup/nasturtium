require_relative "test_helper"
require "byebug"

class TestUser < Test::Unit::TestCase
  def setup
    @id = 20717
    @per_page = 10
  end

  def test_user_id
    VCR.use_cassette("test_user_id") do
      res = Nasturtium.user(@id)
      assert_equal('debpaul', res['results'][0]['login'])
    end
  end

  def test_user_suggest
    VCR.use_cassette("test_user_suggest") do
      res = Nasturtium.user_autocomplete('debpau')
      contains_id = false
      res['results'].each do |r|
        contains_id = true if r['id'] == @id
      end
      assert_true(contains_id)
    end
  end

  def test_user_suggest_limit
    VCR.use_cassette("test_user_suggest_limit") do
      res = Nasturtium.user_autocomplete('ab', per_page: 1)
      assert_equal(1, res['per_page'])
    end
  end

  def test_user_projects
    VCR.use_cassette("test_user_projects") do
      res = Nasturtium.user_projects(@id)
      res['results'].each do |r|
        assert_includes(r, 'project_type')
      end
    end
  end

  def test_user_projects_type
    VCR.use_cassette("test_user_projects_type") do
      res = Nasturtium.user_projects(@id, project_type: 'collection')
      res['results'].each do |r|
        assert_equal('collection', r['project_type'])
      end
    end
  end

  def test_user_projects_pagination_limit
    VCR.use_cassette("test_user_projects_pagination") do
      res = Nasturtium.user_projects(@id, per_page: 1, page: 2)
      assert_equal(1, res['per_page'])
    end
  end

  def test_user_projects_pagination_offset
    VCR.use_cassette("test_user_projects_pagination") do
      res = Nasturtium.user_projects(@id, per_page: 1, page: 2)
      assert_equal('2', res['page'])
    end
  end

  def test_user_me_unauthenticated
    VCR.use_cassette("test_user_me_unauthenticated") do
      res = Nasturtium.user_me()
      assert_equal(401, res['status'])
    end
  end
end