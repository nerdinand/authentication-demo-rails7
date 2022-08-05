# frozen_string_literal: true

require 'securerandom'

class User < ApplicationRecord
  has_secure_password

  validates :email, uniqueness: true, confirmation: true
  validates :username, uniqueness: true

  attr_accessor :email_confirmation

  def start_email_confirmation
    if update(email_confirmation_token: SecureRandom.alphanumeric(20))
      UserMailer.with(user: self).email_confirmation_email.deliver_later
    end
  end

  def start_password_reset
    if update(password_reset_token: SecureRandom.alphanumeric(20))
      UserMailer.with(user: self).password_reset_email.deliver_later
    end
  end

  def email_confirmed?
    email_confirmation_token.blank?
  end
end
