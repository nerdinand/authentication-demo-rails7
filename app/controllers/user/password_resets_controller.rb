class User::PasswordResetsController < ApplicationController
  def new
    @password_reset = User::PasswordReset.new(password_reset_params)
  end

  def create
    user = User.find_by(password_reset_token: password_reset_params[:password_reset_token])

    if user&.update(user_password_params)
      redirect_to :home, notice: 'Successfully changed your password.'
    else
      redirect_to :home, alert: "Couldn't update your password."
    end
  end

  private

  def password_reset_params
    params.require(:user_password_reset).permit(:password_reset_token)
  end

  def user_password_params
    params.require(:user_password_reset).permit(:password, :password_confirmation)
  end
end
