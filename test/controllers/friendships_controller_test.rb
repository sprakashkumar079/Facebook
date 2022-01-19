require 'test_helper'
class FriendshipsControllerTest < ActionDispatch::IntegrationTest

  # setup user for friend to friends
  def setup
    @user1 = users(:michael)
    @user2 = users(:archer)
    @friendship = friendships(:one)
  end

  #test for send friend request to other user
  test 'Sends the request' do
    get user_session_path
    post user_session_path, params: { user: {
                                               email: 'mugoiri@example.com',
                                               password: 'password'
                                            }
                                    }
    follow_redirect!
    get friendships_path
    assert_select 'input[value=?]', 'Accept'
    assert_select 'input[value=?]', 'Reject'
  end

  # User can accept request
  test 'User can accept request' do
    get user_session_path
    post user_session_path, params: { user: {
                                              email: 'mugoiri@example.com',
                                              password: 'password'
                                            }
                                    }
    follow_redirect!
    get friendships_path
    assert_difference 'Friendship.all.count', 1 do
      patch friendship_path(@friendship.id), params: { friendship: { status: true } }
    end
  end

  # User can reject request
  test 'User can reject request' do
    get user_session_path
    post user_session_path, params: { user: {
                                              email: 'mugoiri@example.com',
                                              password: 'password'
                                            }
                                    }
    follow_redirect!
    get friendships_path
    assert_difference 'Friendship.all.count', -1 do
      delete friendship_path(@friendship.id)
    end
  end
end
