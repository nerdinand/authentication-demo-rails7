# frozen_string_literal: true

class User::PasswordReset
  include ActiveModel::Model

  attr_accessor :password_reset_token, :password, :password_confirmation
end
