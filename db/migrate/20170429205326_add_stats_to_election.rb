class AddStatsToElection < ActiveRecord::Migration[5.0]
  def change
    add_column :elections, :seats, :integer
    add_column :elections, :voters_registered, :integer
    add_column :elections, :total_votes, :integer
    add_column :elections, :ballots_rejected, :integer
    add_column :elections, :ballots_valid, :integer
    add_column :elections, :voter_turnout, :float
  end
end
