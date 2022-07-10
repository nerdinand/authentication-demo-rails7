class UserSessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:user_session][:username])

    if user&.authenticate(params[:user_session][:password])
      session[:current_user_id] = user.id
      redirect_to :home
    else
      render :new
    end
  end

  def destroy
    session[:current_user_id] = nil
    redirect_to :home
  end
end
