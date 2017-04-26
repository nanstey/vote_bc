require 'rails_helper'

RSpec.describe Election, type: :model do
  describe 'current_election_year' do
    xit 'should return current election year (2017)' do
      delete_tables
      require Rails.root.join('db', 'scripts', 'seed_elections')
      expect(Election.current_election_year).to eq(2017)
    end
  end
end