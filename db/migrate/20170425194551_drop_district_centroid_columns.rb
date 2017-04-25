class DropDistrictCentroidColumns < ActiveRecord::Migration[5.0]
  def change
    remove_column :districts, :centroid_lat
    remove_column :districts, :centroid_lng
  end
end
