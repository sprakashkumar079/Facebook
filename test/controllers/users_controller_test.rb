# frozen_string_literal: true
require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  # setup for user
  def setup
    @user = users(:michael)
    @other_user = users(:archer)
  end

  #this is new user which wants to sign up
  test "should get new" do
    get new_user_registration_path
    assert_response :success
  end

  # should redirect edit when not logged in
  test "should redirect edit when not logged in" do
    get edit_user_registration_path
    assert_not flash.empty?
    assert_redirected_to new_user_session_path
  end

  # should redirect update when not logged in
  test "should redirect update when not logged in" do
    patch edit_user_registration_path, params: { user: { name: @user.name,
                                                         email: @user.email
                                                       }
                                                }
    assert_not flash.empty?
    assert_redirected_to new_user_session_path
  end

  # should redirect index when not logged in
  test "should redirect index when not logged in" do
    get root_path
    assert_redirected_to new_user_session_path
  end

  # Should redirect destroy when not logged in
  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      destroy_user_session_path(@user)
    end
    assert_redirected_to login_url
  end

  # should redirect destroy when logged in as a non-admin
  test "should redirect destroy when logged in as a non-admin" do
    sign_in_as(@other_user)
    assert_no_difference 'User.count' do
      destroy_user_session_path(@user)
    end
    assert_redirected_to root_url
  end

end