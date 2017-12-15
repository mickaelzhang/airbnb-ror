class RenameTypeToIslandType < ActiveRecord::Migration[5.1]
  def change
    rename_column :islands, :type, :island_type
  end
end
