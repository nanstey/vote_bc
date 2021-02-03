
def read_election_data(year)
  xlsx = Roo::Excelx.new(Rails.root.join('db', 'excel', "#{year}GE-Results-Excel.xlsx"))
  puts "Seeding election results for #{year} ..."

  election = Election.find_by(year: year)

  codes = {}
  registered = {}
  xlsx.each_with_pagename do |name, sheet|

    dis_start_row = sheet.first_row + 2
    curr_row = dis_start_row
    final_row = sheet.last_row
    highest_votes = 0

    while dis_start_row < final_row
      candidates = []
      curr_row = dis_start_row
      # District info
      ed_code = sheet.cell(dis_start_row + 1, sheet.first_column)
      ed_name = sheet.cell(dis_start_row, sheet.first_column)
      district = District.find_by(abbr: ed_code)
      if district.nil?
        district = District.create(name: ed_name, abbr: ed_code)
      end    
      puts "  >> 2020-#{ed_code}"


      # Candidate info
      until sheet.cell(curr_row, 1) == "Final voting results - Complete"
        curr_row += 1
      end
      dis_last_candidate_row = curr_row - 1
      dis_first_candidate_row = dis_last_candidate_row - dis_start_row - 1
      i = 0
      for curr_row in (dis_start_row + 1)..dis_last_candidate_row
        party = sheet.cell(curr_row, sheet.first_column + 2)
        party = 'N/A' if party.nil?
        candidate_name = sheet.cell(curr_row, sheet.first_column + 1)
        candidate_votes_total = sheet.cell(curr_row, sheet.first_column + 3)
        candidate_votes_percent = ((sheet.cell(curr_row, sheet.first_column + 4)).chomp('%')).to_f
        candidates[i] = {name: candidate_name, party: party, votes_total: candidate_votes_total, votes_percent: candidate_votes_percent}
        if sheet.cell(curr_row, sheet.first_column + 3) > highest_votes
          highest_votes = sheet.cell(curr_row, sheet.first_column + 3)
          winner = i
        end
        i += 1
      end
      highest_votes = 0


      # Cumulative vote info
      valid = sheet.cell(dis_last_candidate_row + 1, sheet.first_column + 3)
      total_registered = sheet.cell(dis_last_candidate_row + 3, sheet.first_column + 3)
      rejected = sheet.cell(dis_last_candidate_row + 2, sheet.first_column + 3)
      total_voters = valid + rejected


      # Seed DB
      candidates.each do |c|
        party = Party.find_by(name: (c[:party]))
        candidate = Candidate.find_or_create_by!(name: c[:name], party_id: party.id)
        CandidateElectionDistrict.create!(
          candidate_id: candidate.id,
          election_id: election.id,
          district_id: district.id,
          votes_total: c[:votes_total],
          votes_percent: c[:votes_percent]
        )
      end

      party = Party.find_by(name: (candidates[winner][:party]))
      winning_candidate = Candidate.where(name: candidates[winner][:name], party_id: party.id).first

      ElectionDistrict.create!(
        election_id: election.id,
        district_id: district.id,
        winner_id: winning_candidate.id,
        voters_registered: total_registered,
        total_votes: total_voters,
        ballots_rejected: rejected,
        ballots_valid: valid
      )

      dis_start_row = dis_last_candidate_row + 5
      curr_row = dis_start_row

    end
  end
end

read_election_data(2020)
