# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get new_user_session_url
    assert_response :success
  end

  test 'should register user successfully' do
    assert_emails 1 do
      post users_url, params: {
        user: {
          username: 'user1',
          password: 'user_password1',
          password_confirmation: 'user_password1',
          email: 'user1@example.com',
          email_confirmation: 'user1@example.com'
        }
      }
    end
    refute_nil User.find_by(username: 'user1')
    assert_redirected_to home_url
  end

  test 'should fail to register user with differing passwords' do
    assert_emails 0 do
      post users_url, params: {
        user: {
          username: 'user1',
          password: 'user_password1',
          password_confirmation: 'user_password2',
          email: 'user1@example.com',
          email_confirmation: 'user1@example.com'
        }
      }
    end
    assert_nil User.find_by(username: 'user1')
    assert_response :unprocessable_entity
  end

  test 'should fail to register user with differing emails' do
    assert_emails 0 do
      post users_url, params: {
        user: {
          username: 'user1',
          password: 'user_password1',
          password_confirmation: 'user_password1',
          email: 'user1@example.com',
          email_confirmation: 'user2@example.com'
        }
      }
    end
    assert_nil User.find_by(username: 'user1')
    assert_response :unprocessable_entity
  end
end
