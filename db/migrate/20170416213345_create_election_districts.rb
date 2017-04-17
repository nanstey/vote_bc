class CreateElectionDistricts < ActiveRecord::Migration[5.0]
  def change
    create_table :election_districts do |t|
      t.references :election, index: true, foreign_key: true
      t.references :district, index: true, foreign_key: true
      t.references :winner, index: true, foreign_key: {to_table: :candidates}
      t.integer :voters_registered
      t.integer :total_votes
      t.integer :ballots_rejected
      t.integer :ballots_valid

      t.timestamps
    end
  end
end
