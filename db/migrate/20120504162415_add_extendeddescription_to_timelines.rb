class AddExtendeddescriptionToTimelines < ActiveRecord::Migration
  def change
    add_column :timelines, :extendeddescription, :text
  end
end
