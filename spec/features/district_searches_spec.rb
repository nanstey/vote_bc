require 'rails_helper'

RSpec.feature "Visitor searches an address", type: :feature, js: true do
  before(:each) do
    require Rails.root.join('db', 'scripts', 'seed_parties')
    require Rails.root.join('db', 'scripts', 'seed_elections')
    require Rails.root.join('db', 'scripts', 'import_candidate_election_district_2017')
    url = "https://represent.opennorth.ca/boundaries/british-columbia-electoral-districts-2015-redistribution/abbotsford-south/simple_shape"
    response = HTTP.get(url)
    boundary = JSON.parse(response)
    boundary['coordinates'][0][0].each do |point|
      DistrictPoint.create!(
        district_id: 1,
        lng: point[0],
        lat: point[1]
      )
    end
  end

  scenario "They see abbotsford-south when the full address is typed in" do
    visit root_path
    fill_in 'address', with: '33800 King Rd, Abbotsford, BC V2S 8H8'
    click_on 'Submit'
    # DEBUG / VERIFY
    save_screenshot
  end

  xscenario "They see abbotsford-south when the postalcode is typed in" do
    visit root_path
    fill_in 'address', with: '33800 King Rd, Abbotsford, BC V2S 8H8'
    click_on 'Submit'
    # DEBUG / VERIFY
    save_screenshot
  end

  xscenario "They see abbotsford-south when the coordiates is typed in" do
    visit root_path
    fill_in 'address', with: '33800 King Rd, Abbotsford, BC V2S 8H8'
    click_on 'Submit'
    # DEBUG / VERIFY
    save_screenshot
  end

  xscenario "They see are redirected home when nothing is typed" do
    visit root_path
    fill_in 'address', with: '33800 King Rd, Abbotsford, BC V2S 8H8'
    click_on 'Submit'
    # DEBUG / VERIFY
    save_screenshot
  end

  xscenario "They see are redirected home when an address not in bc is submited" do
    visit root_path
    fill_in 'address', with: '33800 King Rd, Abbotsford, BC V2S 8H8'
    click_on 'Submit'
    # DEBUG / VERIFY
    save_screenshot
  end

end