class AddColumnToTimelines < ActiveRecord::Migration
  def change
    add_column :timelines, :startdate, :date
    add_column :timelines, :enddate, :date
  end
end
