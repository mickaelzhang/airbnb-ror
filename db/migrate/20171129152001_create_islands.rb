class CreateIslands < ActiveRecord::Migration[5.1]
  def change
    create_table :islands do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
