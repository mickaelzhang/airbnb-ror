class AddUserToIslands < ActiveRecord::Migration[5.1]
  def change
    add_reference :islands, :user, foreign_key: true
  end
end
