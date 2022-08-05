# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save && @user.start_email_confirmation
      redirect_to :home,
                  notice: 'Successfully signed up. Please click the confirmation link \
in the email you will receive momentarily.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :email_confirmation, :username, :password, :password_confirmation)
  end
end
