class AddDetailsToIslands < ActiveRecord::Migration[5.1]
  def change
    add_column :islands, :type, :string
    add_column :islands, :size, :integer
    add_column :islands, :location, :string
    add_column :islands, :nb_accomodation, :integer
    add_column :islands, :max_person, :integer
    add_column :islands, :max_bed_room, :integer
    add_column :islands, :max_bed, :integer
    add_column :islands, :max_bath_room, :integer
    add_column :islands, :address, :string
    add_column :islands, :island_options, :text
    add_column :islands, :additional_comment, :text
    add_column :islands, :price_by_night, :integer
  end
end
