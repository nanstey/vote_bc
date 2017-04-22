class CreateDistrictPoints < ActiveRecord::Migration[5.0]
  def change
    create_table :district_points do |t|
      t.references :district, index: true, foreign_key: true
      t.float :lat
      t.float :lng
    end
  end
end
