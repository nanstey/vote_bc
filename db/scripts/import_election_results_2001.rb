
def read_election_data(year)
  xlsx = Roo::Excelx.new(Rails.root.join('db', 'excel', "#{year}GE-Results-Excel.xlsx"))
  puts "Seeding election results for #{year} ..."

  election = Election.find_by(year: year)

  codes = {}
  xlsx.each_with_pagename do |name, sheet|
    # First page ED code collection
    if name == "ED Codes"
      (1..sheet.last_row).each do |i|
        ed_code = sheet.cell(i, 1)
        ed_name = sheet.cell(i, 2)
        codes[ed_code] = ed_name
      end
    else

      puts "  >> #{name}"

      # Get candidate info
      candidates = []
      row = sheet.first_row
      until sheet.cell(row, 1) == "Advance Voting"
        row += 1
      end
      last_candidate = sheet.last_column - 3
      # runs for the 2 different formats of sheets
      if sheet.cell(row-1, 3) == nil
        (4..last_candidate).each do |i|
          party = sheet.cell(row-1, i)
          if party.nil? || party == ' '
            party = 'N/A'
          end
          full_name = "#{sheet.cell(row-3, i).delete("\n")} #{sheet.cell(row-2, i).delete("\n")}"
          candidates[i-4] = {name: full_name, party: party}
        end

        # Get winning candidate
        row = sheet.last_row
        until sheet.cell(row, 1) == "Candidate Elected:"
          row -= 1
        end
        winner = sheet.cell(row, 2)

        # Get district stats
        total_registered = (sheet.cell(row-3, 3)/(sheet.cell(row-3, 4) * 100) * 100).round
        total_voters = sheet.cell(row-3, 3)
        rejected = sheet.cell(row-4, 3)
        valid = sheet.cell(row-6, 3)

        # # Get candidate stats
        until sheet.cell(row, 1) == "Grand Totals"
          row -= 1
        end
        (4..last_candidate).each do |i|
          candidates[i-4][:votes_total] = sheet.cell(row, i)
          candidates[i-4][:votes_percent] = (sheet.cell(row+1, i).to_f * 100).round(2)
        end
      else
        (3..last_candidate).each do |i|
          party = sheet.cell(row-1, i)
          if party.nil? || party == ' '
            party = 'N/A'
          end
          full_name = "#{sheet.cell(row-3, i).delete("\n")} #{sheet.cell(row-2, i).delete("\n")}"
          candidates[i-3] = {name: full_name, party: party}
        end

        # Get winning candidate
        row = sheet.last_row
        until sheet.cell(row, 1) == "Candidate Elected:"
          row -= 1
        end
        winner = sheet.cell(row, 2)

        # Get district stats
        total_registered = (sheet.cell(row-3, 3)/(sheet.cell(row-3, 4) * 100) * 100).round
        total_voters = sheet.cell(row-3, 3)
        rejected = sheet.cell(row-4, 3)
        valid = sheet.cell(row-6, 3)

        # Get candidate stats
        until sheet.cell(row, 1) == "Grand Totals"
          row -= 1
        end
        (3..last_candidate).each do |i|
          candidates[i-3][:votes_total] = sheet.cell(row, i)
          candidates[i-3][:votes_percent] = sheet.cell(row+1, i).to_f * 100
        end
      end

      # Seed info
      ed_code = name.lines('_')[0]
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
      winner_info = winner.scan(/[^()]+/)
      party = Party.find_by(abbr: winner_info[1])
      winning_candidate = Candidate.where(name: winner_info[0].strip, party_id: party.id ).first

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

read_election_data(2001)
