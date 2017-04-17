class CreateElections < ActiveRecord::Migration[5.0]
  def change
    create_table :elections do |t|
      t.integer :year
      t.references :premier, index: true, foreign_key: {to_table: :candidates}

      t.timestamps
    end
  end
end
