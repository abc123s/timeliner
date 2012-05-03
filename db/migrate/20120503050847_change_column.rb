class ChangeColumn < ActiveRecord::Migration
  def up
    rename_column :timelines, :type, :ttype
  end

  def down
    rename_column :timelines, :ttype, :type
  end
end
