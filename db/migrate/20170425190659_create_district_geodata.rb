class CreateDistrictGeodata < ActiveRecord::Migration[5.0]
  def change
    create_table :district_geodata do |t|
      t.references :district, index: true, foreign_key: true
      t.float :centroid_lat
      t.float :centroid_lng
      t.float :extent_south
      t.float :extent_west
      t.float :extent_north
      t.float :extent_east

      t.timestamps
    end
  end
end
