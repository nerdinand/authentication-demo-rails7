# frozen_string_literal: true

class AddEmailConfirmationTokenToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :email_confirmation_token, :string
  end
end
