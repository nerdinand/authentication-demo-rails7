# frozen_string_literal: true

require 'test_helper'

class User::EmailConfirmationsControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get new_user_email_confirmation_url, params: {
      user_email_confirmation: { email_confirmation_token: 'iYQ6tXWC53k4bfQRo6u9' }
    }
    assert_response :success
  end

  test 'should successfully confirm email address with the correct token' do
    post user_email_confirmations_url, params: {
      user_email_confirmation: { email_confirmation_token: 'iYQ6tXWC53k4bfQRo6u9' }
    }

    assert users(:user_with_unconfirmed_email).email_confirmation_token.blank?
    assert_redirected_to :home
  end

  test 'should fail to confirm email address with the wrong token' do
    post user_email_confirmations_url, params: {
      user_email_confirmation: { email_confirmation_token: 'wrong_token' }
    }

    assert users(:user_with_unconfirmed_email).email_confirmation_token.present?
    assert_redirected_to :home
  end

  test 'should resend email confirmation email when logged in' do
    post user_session_url, params: { user_session: { username: 'user_with_unconfirmed_email', password: 'mypassword' } }

    assert_emails 1 do
      post user_email_confirmations_resend_url
    end

    assert_redirected_to :home
  end

  test 'should not resend email confirmation email when not logged in' do
    assert_emails 0 do
      post user_email_confirmations_resend_url
    end

    assert_redirected_to :home
  end
end
