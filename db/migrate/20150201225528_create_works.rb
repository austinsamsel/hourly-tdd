class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.string :title
      t.text :description
      t.boolean :billed, default: false

      t.timestamps null: false
    end
  end
end
