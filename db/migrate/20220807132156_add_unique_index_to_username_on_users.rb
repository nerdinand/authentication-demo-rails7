# frozen_string_literal: true

class AddUniqueIndexToUsernameOnUsers < ActiveRecord::Migration[7.0]
  def change
    add_index :users, %i[username], unique: true
  end
end
