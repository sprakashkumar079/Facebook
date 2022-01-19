require 'test_helper'
class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  #unsuccessful edit
  test "unsuccessful edit" do
    signed_in_as(@user)
    get edit_user_registration_path
    assert_template 'users/edit'
    patch user_path(@user), params: { user:
                                          { name: "",
                                            email: "foo@invalid",
                                            password: "foo",
                                            password_confirmation: "bar"
                                          }
                                    }
    assert_template 'users/edit'
  end

  #successful user update for current user
  test "successful edit" do
    sign_in_as(@user)
    get edit_user_registration_path
    assert_template 'users/edit'
    name = "Foo Bar"
    email = "foo@bar.com"
    patch user_registration_path, params: { user:
                                             { name: name,
                                              email: email,
                                              password: "",
                                              password_confirmation: ""
                                            }
                                    }
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  #successful user update for current user
  test "successful edit with friendly forwarding" do
    get edit_user_registration_path
    sign_in_as(@user)
    assert_redirected_to edit_user_registration_path
    name = "Foo Bar"
    email = "foo@bar.com"
    patch user_registration_path, params: { user:
                                             { name: name,
                                              email: email,
                                              password: "",
                                              password_confirmation: ""
                                            }
                                    }
    assert_not flash.empty?
    assert_redirected_to root_path
  end
end