require 'rails_helper'

RSpec.describe District, type: :model do

  describe 'get_geolocation' do
    it 'should return corresponding co-ordinates for address' do
      geolocation = District.get_geolocation('35131 Straiton Rd, Abbotsford, BC V2S 7Z1')
      expect(geolocation).to eq(Hash["lat", 49.083122, "lng", -122.2514328])
    end

    it 'should return same co-ordinates for co-ordinates' do
      geolocation = District.get_geolocation('49.083122,-122.2514328')
      expect(geolocation).to eq(Hash["lat", 49.083122, "lng", -122.2514328])
    end

    it 'should return corresponding co-ordinates for postal' do
      geolocation = District.get_geolocation('V2S 7Z1')
      expect(geolocation).to eq(Hash["lat", 49.0833702, "lng", -122.2483337])
    end

    it 'should return nil for nothing' do
      geolocation = District.get_geolocation('')
      expect(geolocation).to eq(nil)
    end

    it 'should return nil for gibberish' do
      geolocation = District.get_geolocation('sahrrashbrzshehasej')
      expect(geolocation).to eq(nil)
    end
  end

  describe 'get_district' do
    it 'should return corresponding district name' do
      party_and_election
      create_district

      district_name = District.get_district(Hash["lat", 49.083122, "lng", -122.2514328])
      expect(district_name).to eq(District.find_by name: 'Abbotsford-Mission')
    end

    it 'should return nil for co-ordinates outside BC' do
      party_and_election
      create_district

      district_name = District.get_district(Hash["lat", 44.6514643, "lng", -63.5947314])
      expect(district_name).to eq(nil)
    end
    it 'should return nil for co-ordinates that dont exist' do
      party_and_election
      create_district

      district_name = District.get_district(Hash["lat", 144.6514643, "lng", -163.5947314])
      expect(district_name).to eq([])
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
