require_relative "test_helper"

class TestUser < Test::Unit::TestCase
  def setup
    @per_page = 10
  end

  def test_posts_login
    VCR.use_cassette("test_posts_login") do
      res = Nasturtium.posts(login: 'loarie', per_page: @per_page)
      res.each do |post|
        assert_equal(post['user_id'], 477)
      end
    end
  end

  def test_posts_parent_id
    VCR.use_cassette("test_posts_parent_id") do
      res = Nasturtium.posts(parent_id: 1)
      res.each do |post|
        assert_equal(post['parent_id'], 1)
      end
    end
  end

  def test_posts_project_id
    VCR.use_cassette("test_posts_project_id") do
      res = Nasturtium.posts(project_id: 42768)
      res.each do |post|
        assert_equal(post['parent_id'], 42768)
      end
    end
  end

  def test_posts_per_page
    VCR.use_cassette("test_posts_per_page") do
      res = Nasturtium.posts(per_page: 3)
      assert_equal(res.size, 3)
    end
  end

end