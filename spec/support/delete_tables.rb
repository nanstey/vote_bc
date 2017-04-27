def delete_tables
  DistrictAlias.destroy_all
  DistrictPoint.destroy_all
  CandidateAlias.destroy_all
  CandidateElectionDistrict.destroy_all
  ElectionDistrict.destroy_all
  ElectionLeader.destroy_all
  Election.destroy_all
  District.destroy_all
  Candidate.destroy_all
  Party.destroy_all
end