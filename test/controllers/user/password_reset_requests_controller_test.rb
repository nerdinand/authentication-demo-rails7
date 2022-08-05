# frozen_string_literal: true

require 'test_helper'

class User::PasswordResetRequestsControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get new_user_password_reset_request_url
    assert_response :success
  end

  test 'should successfully request a password reset with a username' do
    assert_emails 1 do
      post user_password_reset_requests_url, params: {
        user_password_reset_request: { email_or_username: 'user' }
      }
    end
    assert users(:user).password_reset_token.present?
    assert_redirected_to :home
  end

  test 'should successfully request a password reset with an email' do
    assert_emails 1 do
      post user_password_reset_requests_url, params: {
        user_password_reset_request: { email_or_username: 'user@example.com' }
      }
    end
    assert users(:user).password_reset_token.present?
    assert_redirected_to :home
  end

  test 'should fail to request a password reset' do
    assert_emails 0 do
      post user_password_reset_requests_url, params: {
        user_password_reset_request: { email_or_username: 'non_existant_user' }
      }
    end
    assert users(:user).password_reset_token.blank?
    assert_redirected_to :home
  end
end
