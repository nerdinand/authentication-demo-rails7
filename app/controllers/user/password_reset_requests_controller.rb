# frozen_string_literal: true

module User
  class PasswordResetRequestsController < ApplicationController
    def new
      @password_reset_request = User::PasswordResetRequest.new
    end

    def create
      email_or_username = password_reset_request_params[:email_or_username]
      user = User.where(username: email_or_username).or(User.where(email: email_or_username)).first

      user&.start_password_reset

      redirect_to :home, notice: 'Please click the password reset link in the email you will receive momentarily.'
    end

    private

    def password_reset_request_params
      params.require(:user_password_reset_request).permit(:email_or_username)
    end
  end
end
