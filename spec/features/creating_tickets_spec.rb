require 'spec_helper'

feature 'Creating Tickets' do
  before do
    project = FactoryGirl.create(:project)
    user = FactoryGirl.create(:user)
    define_permission!(user, "view", project)
    define_permission!(user, "create tickets", project)
    # Defining user to view the project
    @email = user.email
    sign_in_as!(user)

    visit '/'
    click_link project.name
    click_link 'New Ticket'
    # message = "You need to sign in or sign up before continuing."
    # expect(page).to have_content(message)

    # fill_in "Name", with: user.name
    # fill_in "Password", with: user.password
    # click_button "Sign in"

    # click_link project.name
    # click_link "New Ticket"
  end
  # before do
  #   FactoryGirl.create(:project, name: "Lawyer.ly")
  #   visit '/'
  #   click_link 'Lawyer.ly'
  #   click_link 'New Ticket'
  # end


  scenario "Create a ticket inside a project" do
    fill_in "Title", with: "Non-standards compliance"
    fill_in "Description", with: "My pages are not accessible"
    click_button "Create Ticket"

    expect(page).to have_content("Ticket has been created.")

    within "#ticket #author" do
      expect(page).to have_content("Created by")
    end
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
