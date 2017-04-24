class CreateCandidateAliases < ActiveRecord::Migration[5.0]
  def change
    create_table :candidate_aliases do |t|
      t.integer :candidate_id
      t.integer :old_candidate_id

      t.timestamps
    end
  end
end
