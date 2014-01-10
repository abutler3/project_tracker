require 'spec_helper'

feature 'Creating Tickets' do
  before do
    FactoryGirl.create(:project, name: "Lawyer.ly")
    visit '/'
    click_link 'Lawyer.ly'
    click_link 'New Ticket'
  end

  scenario "Create a ticket inside a project" do
    fill_in "Title", with: "Non-standards compliance"
    fill_in "Description", with: "My pages are not accessible"
    click_button "Create Ticket"

    expect(page).to have_content("Ticket has been created.")
  end

  scenario "Create a ticket without valid attributes fails" do
    click_button "Create Ticket"

    expect(page).to have_content("Ticket has not been created.")
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Description can't be blank")

  end

  scenario "Description must be longer than 10 characters" do
    fill_in "Title", with: "Non-standards compliance"
    fill_in "Description", with: "It sucks"
    click_button "Create Ticket"

    expect(page).to have_content("Ticket has not been created.")
    expect(page).to have_content("Description is too short")


  end
end
