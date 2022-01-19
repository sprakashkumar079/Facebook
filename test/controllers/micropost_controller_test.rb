# frozen_string_literal: true

require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:archer)
  end

  # testing for creating post when logged in
  test 'creates post when logged in' do
    get user_session_path
    assert_equal 200, status
    post user_session_path, params: { user: {
                                              email: @user.email,
                                              password: 'password'
                                             }
                                    }
    follow_redirect!
    assert_equal 200, status
    assert_difference 'Post.count', 1 do
      post posts_path, params: { post: { body: 'Lorem ipsum' } }
    end
    assert_redirected_to posts_path
  end

  # testing for redirects when trying to create a post if not logged in
  test 'redirects when trying to create a post if not logged in' do
    assert_no_difference 'Post.count' do
      post posts_path, params: { post: { body: 'Lorem ipsum' } }
    end
    assert_redirected_to new_user_session_path
  end
end
