# frozen_string_literal: true

class User::PasswordResetRequest
  include ActiveModel::Model

  attr_accessor :email_or_username
end
