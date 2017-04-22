class AddCentroidToDistricts < ActiveRecord::Migration[5.0]
  def change
    add_column :districts, :centroid_lat, :float
    add_column :districts, :centroid_lng, :float
  end
end
