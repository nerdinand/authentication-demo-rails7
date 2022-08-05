# frozen_string_literal: true

require 'test_helper'

class UserSessionsControllerTest < ActionDispatch::IntegrationTest
  fixtures :users

  test 'should get new' do
    get new_user_session_url
    assert_response :success
  end

  test 'should log user in successfully' do
    post user_session_url, params: { user_session: { username: 'user', password: 'user_password' } }
    assert_equal users(:user).id, session[:current_user_id]
    assert_redirected_to home_url
  end

  test 'should fail to log in user' do
    post user_session_url, params: { user_session: { username: 'user', password: 'wrong_password' } }
    assert_nil session[:current_user_id]
    assert_response :unprocessable_entity
  end

  test 'should log out user' do
    post user_session_url, params: { user_session: { username: 'user', password: 'user_password' } }
    assert_redirected_to home_url

    delete user_session_url
    assert_nil session[:current_user_id]
    assert_redirected_to home_url
  end
end
