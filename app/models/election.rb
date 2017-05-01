class Election < ApplicationRecord
  validates :year, presence: true, uniqueness: true
  has_many :election_districts
  has_many :candidate_election_districts
  has_many :districts, through: :election_districts
  has_many :candidates, through: :candidate_election_districts
  has_many :election_leaders
  has_many :leaders, through: :election_leaders
  has_many :parties, through: :leaders

  def self.current_election_year
    2017
  end

  def self.last_election_year
    2013
  end

  def party_stats
    if self.voters_registered.nil?
      return nil
    end
    eps = ElectionParty.includes(:party).where(:election_id => self.id).order(:seats_won => :DESC, :votes_total => :DESC)
    didnt_vote = self.voters_registered - self.total_votes
    party_stats = {
      all_parties: eps,
      json_seats: {
        data: [],
        colors: []
      },
      json_votes: {
        data:[{label: "Didn't Vote", value: (didnt_vote)}],
        colors: ['#24292e']
      }
    }

    eps.each_with_index do |ep, i|
      if i < 5
        party_stats[:json_votes][:data] << {label: ep.party.abbr, value: ep.votes_total}
        party_stats[:json_votes][:colors] << ep.party.color
      elsif i == 5
        party_stats[:json_votes][:data] << {label: 'Other', value: ep.votes_total}
        party_stats[:json_votes][:colors] << '#505050'
      else
        party_stats[:json_votes][:data][6][:value] += ep.votes_total
      end
      if ep.seats_won > 0
        party_stats[:json_seats][:data] << {label: ep.party.abbr, value: ep.seats_won}
        party_stats[:json_seats][:colors] << ep.party.color
      end
    end
    party_stats[:json_votes][:data] = party_stats[:json_votes][:data].to_json.html_safe
    party_stats[:json_votes][:colors] = party_stats[:json_votes][:colors].to_json.html_safe
    party_stats[:json_seats][:data] = party_stats[:json_seats][:data].to_json.html_safe
    party_stats[:json_seats][:colors] = party_stats[:json_seats][:colors].to_json.html_safe

    party_stats
  end

end
