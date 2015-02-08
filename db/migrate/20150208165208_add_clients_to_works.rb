class AddClientsToWorks < ActiveRecord::Migration
  def change
    add_reference :works, :client, index: true
    add_foreign_key :works, :clients
  end
end
