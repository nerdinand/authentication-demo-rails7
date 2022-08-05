# frozen_string_literal: true

require 'test_helper'

class User::PasswordResetsControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get new_user_password_reset_url, params: { user_password_reset: { password_reset_token: 'my_token' } }
    assert_response :success
  end

  test 'should successfully do reset' do
    post user_password_resets_url, params: {
      user_password_reset: {
        password_reset_token: 'Tm8Gv9VP4XsHnIJyosk7',
        password: 'new_password',
        password_confirmation: 'new_password'
      }
    }

    assert users(:user_with_open_password_reset_request).password_reset_token.blank?
    assert_redirected_to :home
  end

  test 'should fail to do a password reset with a wrong token' do
    post user_password_resets_url, params: {
      user_password_reset: {
        password_reset_token: 'wrong_token',
        password: 'new_password',
        password_confirmation: 'new_password'
      }
    }

    assert users(:user_with_open_password_reset_request).password_reset_token.present?
    assert_redirected_to :home
  end

  test 'should fail to do a password reset with non-matching password' do
    post user_password_resets_url, params: {
      user_password_reset: {
        password_reset_token: 'Tm8Gv9VP4XsHnIJyosk7',
        password: 'new_password',
        password_confirmation: 'new_password2'
      }
    }

    assert users(:user_with_open_password_reset_request).password_reset_token.present?
    assert_redirected_to :home
  end
end
