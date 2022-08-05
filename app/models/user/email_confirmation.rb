# frozen_string_literal: true

class User::EmailConfirmation
  include ActiveModel::Model

  attr_accessor :email_confirmation_token
end
