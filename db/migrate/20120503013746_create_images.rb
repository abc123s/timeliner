class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :title
      t.references :event
      t.timestamps
    end
  end
end
