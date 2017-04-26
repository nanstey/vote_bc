require 'rails_helper'

RSpec.feature "Visitor clicks the elections dropdown", type: :feature, js: true do

  before(:each) do
    party_and_election
  end

  scenario "They see all the years of the stored elections", js: true do

    visit root_path
    save_screenshot

    click_on 'Elections'
    save_screenshot
    expect(page).to have_css('.fa-caret-right.down')

  end

  scenario "from mobile menu and it will open", js: true do

    page.driver.resize(500, 1000)

    visit root_path

    within('.navbar') { page.find('.menu-icon').click }

    click_on 'Elections'

    within('.navbar') { expect(page).to have_text('2017') }

  end

  scenario "from mobile menu and then clicks the menu-icon. they both will collapse", js: true do

    page.driver.resize(500, 1000)

    visit root_path

    within('.navbar') { page.find('.menu-icon').click }

    click_on 'Elections'

    within('.navbar') { page.find('.menu-icon').click }

    expect(page).to have_css('.fa-caret-right.up')
  end

end
