
def read_election_data(year)
  xlsx = Roo::Excelx.new(Rails.root.join('db', 'excel', "#{year}GE-Results-Excel.xlsx"))
  puts "Seeding election results for #{year} ..."

  election = Election.find_by(year: year)

  codes = {}
  registered = {}
  xlsx.each_with_pagename do |name, sheet|
    # First page ED code collection
    if name == "ED List"
      (1..sheet.last_row).each do |i|
        ed_code = sheet.cell(i, 1)
        ed_name = sheet.cell(i, 2)
        codes[ed_code] = ed_name
      end
    elsif name == "Registered"
      last_registered = sheet.last_row
      (1..last_registered).each do |i|
        ed = sheet.cell(i, 1)
        reg = sheet.cell(i, 2)
        registered[ed] = reg
      end

    else
      puts "  >> #{name}"
      # Get winning candidate
      last_candidate = sheet.last_column - 2
      row = sheet.last_row
      until sheet.cell(row, 1) == "Grand totals"
        row -= 1
      end

      winner_col = 2
      (3..last_candidate).each do |i|
        if sheet.cell(row, i) > sheet.cell(row, winner_col)
          winner_col = i
        end
      end

      rejected = sheet.cell(row, sheet.last_column)
      valid = sheet.cell(row, sheet.last_column-1)
      total_voters = rejected + valid
      total_registered = registered[name]


      # Get candidate info
      candidates = []
      row = sheet.first_row
      until sheet.cell(row, 1) == "Advance voting"
        row += 1
      end
      (2..last_candidate).each do |i|
        party = sheet.cell(row-1, i)
        party = 'N/A' if party.nil?
        candidates[i-2] = {name: sheet.cell(row-2, i).delete("\n"), party: party}
      end

      winner = sheet.cell(row-2, winner_col)
      winner_party = sheet.cell(row-1, winner_col)

      # Get candidate stats
      row = sheet.last_row
      until sheet.cell(row, 1) == "Grand totals"
        row -= 1
      end
      (2..last_candidate).each do |i|
        candidates[i-2][:votes_total] = sheet.cell(row, i)
        candidates[i-2][:votes_percent] = ((sheet.cell(row, i).to_f/valid.to_f).to_f * 100).round(2)
      end

      # Seed info
      ed_code = name
      ed_name = codes[ed_code]
      district = District.find_by(name: ed_name)
      if district.nil?
        district = District.create(name: ed_name, abbr: ed_code)
      end

      candidates.each do |c|
        party = Party.find_by(abbr: c[:party])
        candidate = Candidate.find_or_create_by!(name: c[:name], party_id: party.id)
        CandidateElectionDistrict.create!(
          candidate_id: candidate.id,
          election_id: election.id,
          district_id: district.id,
          votes_total: c[:votes_total],
          votes_percent: c[:votes_percent]
        )
      end

      party = Party.find_by(abbr: winner_party)
      winning_candidate = Candidate.where(name: winner, party_id: party.id ).first

      ElectionDistrict.create!(
        election_id: election.id,
        district_id: district.id,
        winner_id: winning_candidate.id,
        voters_registered: total_registered,
        total_votes: total_voters,
        ballots_rejected: rejected,
        ballots_valid: valid
      )
    end
  end
end

read_election_data(2020)
