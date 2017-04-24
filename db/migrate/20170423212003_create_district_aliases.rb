class CreateDistrictAliases < ActiveRecord::Migration[5.0]
  def change
    create_table :district_aliases do |t|
      t.integer :district_id
      t.integer :old_district_id
      t.integer :year

      t.timestamps
    end
  end
end
