class User::EmailConfirmationsController < ApplicationController
  def new
    @email_confirmation = User::EmailConfirmation.new(email_confirmation_params)
  end

  def create
    user = User.find_by(email_confirmation_params)

    if user&.update(email_confirmation_token: nil)
      redirect_to :home, notice: 'Successfully confirmed your email address.'
    else
      redirect_to :home, alert: "Couldn't confirm your email address."
    end
  end

  def resend
    if helpers.logged_in? && helpers.current_user.start_email_confirmation
      redirect_to :home, notice: 'Please click the confirmation link in the email you will receive momentarily.'
    else
      redirect_to :home, alert: "Couldn't send confirmation email. Please try again later."
    end
  end

  private

  def email_confirmation_params
    params.require(:user_email_confirmation).permit(:email_confirmation_token)
  end
end
