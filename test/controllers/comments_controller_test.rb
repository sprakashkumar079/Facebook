require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest

  #setup user for comments
  def setup
    @user = users(:michael)
    @comment = comments(:one)
  end
  # user can post a comment when logged in
  test 'user can post a comment when logged in' do
    get user_session_path
    assert_equal 200, status
    post user_session_path, params: { user: {
                                              email: @user.email,
                                              password: 'password'
                                            }
                                    }
    follow_redirect!
    assert_equal 200, status
    get posts_path
    assert_difference 'Comment.count', 1 do
      post comments_path, params: { comment: { body: 'Lorem ipsum',
                                               post_id: @comment.post.id,
                                               user_id: @user.id
                                             }
                                  }
    end
    assert_redirected_to posts_path
  end

   # testing for redirects when trying to create a comments if not logged in
  test 'redirects when trying to create a post if not logged in' do
    assert_no_difference 'Comment.count' do
      post posts_path, params: { comment: { body: 'Lorem ipsum',
                                            post_id: @comment.post.id,
                                            user_id: @user.id
                                          }
                                }
    end
    assert_redirected_to new_user_session_path
  end
end
