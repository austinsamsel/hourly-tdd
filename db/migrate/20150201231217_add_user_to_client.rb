class AddUserToClient < ActiveRecord::Migration
  def change
    add_reference :clients, :user, index: true
    add_foreign_key :clients, :users
  end
end
