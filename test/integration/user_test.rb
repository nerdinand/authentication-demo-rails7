# frozen_string_literal: true

require 'test_helper'

class UserTest < ActionDispatch::IntegrationTest
  fixtures :users

  test 'can sign up' do
    get '/'
    assert_response :success
    assert_select 'a[href="/sign_up"]', 'sign up'

    get '/sign_up'
    assert_response :redirect
    follow_redirect!
    assert_response :success

    assert_select 'h1', 'Sign up'
    assert_select 'form[action="/users"]'
    assert_emails 1 do
      post '/users', params: {
        user: {
          email: 'foo@bar.com',
          email_confirmation: 'foo@bar.com',
          username: 'foo',
          password: 'bar',
          password_confirmation: 'bar'
        }
      }
    end
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select 'p.notice',
                  'Successfully signed up. Please click the confirmation link in the email you will receive momentarily.'
  end

  test 'can confirm email' do
    get '/user/email_confirmations/new?user_email_confirmation%5Bemail_confirmation_token%5D=iYQ6tXWC53k4bfQRo6u9'
    assert_response :success
    assert_select 'h1', 'Confirm your email'
    assert_select 'form[action="/user/email_confirmations"]'

    post '/user/email_confirmations', params: {
      user_email_confirmation: { email_confirmation_token: 'iYQ6tXWC53k4bfQRo6u9' }
    }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select 'p.notice', 'Successfully confirmed your email address.'
  end

  test 'can log in and out' do
    get '/'
    assert_response :success
    assert_select 'a[href="/log_in"]', 'log in'

    get '/log_in'
    assert_response :redirect
    follow_redirect!
    assert_response :success

    assert_select 'h1', 'Log in'
    assert_select 'form[action="/user_session"]'
    post '/user_session', params: { user_session: { username: 'user', password: 'user_password' } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select 'h1', 'Welcome'
    assert_select 'p', 'You are logged in as user.'
    assert_select 'form[action="/log_out"]'

    delete '/log_out'
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select 'h1', 'Welcome'
    assert_select 'p', 'You are not logged in.'
  end

  test 'can reset password' do
    get '/log_in'
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select 'a[href="/user/password_reset_requests/new"]', 'Reset password'

    get '/user/password_reset_requests/new'
    assert_response :success
    assert_select 'h1', 'Reset your password'
    assert_select 'form[action="/user/password_reset_requests"]'

    assert_emails 1 do
      post '/user/password_reset_requests',
           params: { user_password_reset_request: { email_or_username: 'user@example.com' } }
    end
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select 'p.notice', 'Please click the password reset link in the email you will receive momentarily.'

    password_reset_token = users(:user).password_reset_token
    get '/user/password_resets/new', params: { user_password_reset: { password_reset_token: } }
    assert_response :success
    assert_select 'h1', 'Reset your password'
    assert_select 'form[action="/user/password_resets"]'

    post '/user/password_resets', params: {
      user_password_reset: { password_reset_token: },
      password: 'new_password',
      password_confirmation: 'new_password'
    }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select 'p.notice', 'Successfully changed your password.'
  end
end
