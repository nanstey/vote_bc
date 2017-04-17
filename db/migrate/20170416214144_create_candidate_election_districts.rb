class CreateCandidateElectionDistricts < ActiveRecord::Migration[5.0]
  def change
    create_table :candidate_election_districts do |t|
      t.references :candidate, index: true, foreign_key: true
      t.references :election, index: true, foreign_key: true
      t.references :district, index: true, foreign_key: true
      t.integer :votes_total
      t.float :votes_percent

      t.timestamps
    end
  end
end
