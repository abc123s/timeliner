class CreateTimelines < ActiveRecord::Migration
  def change
    create_table :timelines do |t|
      t.string :title
      t.text :description
      t.integer :type
      t.references :user
      t.timestamps
    end
  end
end
