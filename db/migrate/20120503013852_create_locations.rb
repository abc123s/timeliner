class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :title
      t.float :latitude
      t.float :longitude
      t.references :event
      t.timestamps
    end
  end
end
