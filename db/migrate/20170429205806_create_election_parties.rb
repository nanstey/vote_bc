class CreateElectionParties < ActiveRecord::Migration[5.0]
  def change
    create_table :election_parties do |t|
      t.integer :election_id
      t.integer :party_id
      t.integer :candidates_running
      t.integer :seats_won
      t.integer :votes_total
      t.float :votes_percent

      t.timestamps
    end
  end
end
