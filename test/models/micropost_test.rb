require "test_helper"

class MicropostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  def setup
    @user = users(:michael)
    @micropost = @user.microposts.build(content: "Lorem ipsum")
  end

  #checking validation
  test "should be valid" do
    assert @micropost.valid?
  end

  #checking user id present or not
  test "user id should be present" do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end

  #content should be present
  test "content should be present" do
    @micropost.content = " "
    assert_not @micropost.valid?
  end

  #content should be at most 140 characters
  test "content should be at most 140 characters" do
    @micropost.content = "a" * 141
    assert_not @micropost.valid?
  end

  #order should be most recent first
  test "order should be most recent first" do
    assert_equal microposts(:most_recent), Micropost.first
  end
end