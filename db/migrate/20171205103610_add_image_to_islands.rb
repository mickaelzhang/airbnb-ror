class AddImageToIslands < ActiveRecord::Migration[5.1]
  def change
    add_column :islands, :image, :string
  end
end
