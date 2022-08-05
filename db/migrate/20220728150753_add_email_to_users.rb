# frozen_string_literal: true

class AddEmailToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :email, :string, null: false, index: { unique: true }
  end
end
