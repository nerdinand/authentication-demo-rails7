# frozen_string_literal: true

module ApplicationHelper
  def logged_in?
    current_user.present?
  end

  def current_user
    User.find_by(id: session[:current_user_id])
  end
end
