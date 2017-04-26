require 'rails_helper'

RSpec.describe District, type: :model do

  describe 'get_geolocation' do
    it 'should return corresponding co-ordinates' do
      geolocation = District.get_geolocation('35131 Straiton Rd, Abbotsford, BC V2S 7Z1')
      expect(geolocation).to eq(Hash["lat", 49.083122, "lng", -122.2514328])
    end
  end

  describe 'get_district' do
    it 'should return corresponding district name' do
      party_and_election
      create_district

      district_name = District.get_district(Hash["lat", 49.083122, "lng", -122.2514328])
      expect(district_name).to eq(District.find_by name: 'Abbotsford-Mission')
    end
  end

  describe 'get_graph_data' do
    it 'should return corresponding graph data' do
      party_and_election
      create_district
      create_election_result

      expected_result = '[{"year":2009,"LIB":58.36,"NDP":32.57,"GP":9.07,"Other":null},{"year":2013,"LIB":50.67,"NDP":27.2,"CP":9.47,"GP":9.07,"BCEX":0.58,"Other":3.01},{"year":2017,"CHP":null,"Other":null}]'

      am_district = District.all
      expect(am_district[0].get_graph_data).to eq(expected_result)
    end
  end

end
