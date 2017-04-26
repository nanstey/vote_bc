require 'rails_helper'

RSpec.feature "Visitor clicks the elections dropdown", type: :feature do

  before(:each) do
    party_and_election
  end

  scenario "They see all the years of the stored elections" do

    visit root_path

    click_on 'Elections'

    within('.navbar') { expect(page).to have_text('2017') && have_text('2013')}

    save_screenshot

  end





end
