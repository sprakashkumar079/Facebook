require 'test_helper'
class UserTest < ActiveSupport::TestCase
  #setup for user
  def setup
    @user = User.new(first_name: "Example ",
                     last_name: "User",
                     email: "user@example.com",
                     password: "foobar",
                     password_confirmation: "foobar")
  end

  #name should be present
  test "name should be present" do
    @user.first_name = "a" * 31
    assert_not @user.valid?
  end

  # last_name should be present
  test "last_name should be present" do
    @user.last_name = "a" * 31
    assert_not @user.valid?
  end

  #emails should be present
  test "email should be present" do
    @user.email = " "
    assert_not @user.valid?
  end

  # password should be present (non blank)
  test "password should be present (non blank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  # password should have a minimum length
  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
end