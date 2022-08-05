# frozen_string_literal: true

module User
  class EmailConfirmation
    include ActiveModel::Model

    attr_accessor :email_confirmation_token
  end
end
