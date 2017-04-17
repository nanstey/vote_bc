class CreateElectionLeaders < ActiveRecord::Migration[5.0]
  def change
    create_table :election_leaders do |t|
      t.references :candidate, index: true, foreign_key: true
      t.references :election, index: true, foreign_key: true

      t.timestamps
    end
  end
end
