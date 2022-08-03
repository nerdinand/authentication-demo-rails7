class UserMailer < ApplicationMailer
  def email_confirmation_email
    @user = params[:user]
    @email_confirmation_url = new_user_email_confirmation_url(user_email_confirmation: {email_confirmation_token: @user.email_confirmation_token})
    mail(to: @user.email, subject: 'Please confirm your email address')
  end
end
