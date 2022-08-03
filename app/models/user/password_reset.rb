class User::PasswordReset
  include ActiveModel::Model

  attr_accessor :password_reset_token
  attr_accessor :password
  attr_accessor :password_confirmation
end
