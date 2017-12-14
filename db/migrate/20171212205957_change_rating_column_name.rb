class ChangeRatingColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :ratings, :rating, :rating_score
  end
end
