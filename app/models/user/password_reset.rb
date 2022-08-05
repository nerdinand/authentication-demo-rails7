# frozen_string_literal: true

module User
  class PasswordReset
    include ActiveModel::Model

    attr_accessor :password_reset_token, :password, :password_confirmation
  end
end
