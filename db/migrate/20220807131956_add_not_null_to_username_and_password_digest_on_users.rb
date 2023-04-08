# frozen_string_literal: true

class AddNotNullToUsernameAndPasswordDigestOnUsers < ActiveRecord::Migration[7.0]
  def change
    change_column_null :users, :username, false
    change_column_null :users, :password_digest, false
  end
end
