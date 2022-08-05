# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def email_confirmation_email
    @user = params[:user]
    @email_confirmation_url = new_user_email_confirmation_url(
      user_email_confirmation: { email_confirmation_token: @user.email_confirmation_token }
    )
    mail(to: @user.email, subject: 'Please confirm your email address')
  end

  def password_reset_email
    @user = params[:user]
    @password_reset_url = new_user_password_reset_url(
      user_password_reset: { password_reset_token: @user.password_reset_token }
    )
    mail(to: @user.email, subject: 'Reset your password')
  end
end
