# frozen_string_literal: true
require 'test_helper'
class UsersSigninTest < ActionDispatch::IntegrationTest
  #signin for new user
  test "should get new" do
    get  new_user_session_path
    assert_response :success
  end

  #login with invalid information
  test "login with invalid information" do
    get new_user_session_path
    assert_template 'sessions/new'
    post user_session_path, params: { session: { email: "", password: "" } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "login with valid emails/invalid password information" do
    get new_user_session_path
    assert_template 'sessions/new'
    post user_session_path, params: { session: { email: "", password: "invalid" } }
    assert_not user_signed_in?
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  #login with valid information
  test "login with valid information" do
    get new_user_session_path
    post user_session_path, params: { session: { email: 'mohan@gamil.com',
                                                 password: 'password'
                                               }
                                    }
    assert_redirected_to root_path
    follow_redirect!
    assert_template 'users/index'
    assert_select "a[href=?]", user_session_path
    assert_select "a[href=?]", user_session_path
    assert_select "a[href=?]", user_path(@user)
  end

  #login with valid information followed by logout
  test "login with valid information followed by logout" do
    get new_user_session_path
    post user_session_path, params: { session: { email: 'mohan@gamil.com',
                                                 password: 'password'
                                               }
                                    }
    assert_redirected_to root_path
    follow_redirect!
    assert_template 'users/index'
    assert_select "a[href=?]", user_session_path
    assert_select "a[href=?]", user_session_path
    assert_select "a[href=?]", user_path(@user)

    delete destroy_user_session_path
    assert_not user_signed_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", user_session_path
    assert_select "a[href=?]", destroy_user_session_path
    assert_select "a[href=?]", user_path(@user)
  end


  test "login with remembering" do
    sign_in_as(@user, remember_me: '1')
    assert_not_empty cookies[:remember_token]
  end

  test "login without remembering" do
    # Log in to set the cookie.
    sign_in_as(@user, remember_me: '1')
    # Log in again and verify that the cookie is deleted.
    sign_in_as(@user, remember_me: '0')
    assert_empty cookies[:remember_token]
    end
end