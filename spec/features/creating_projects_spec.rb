require 'spec_helper'

feature 'Creating Projects' do
  scenario "can create a project" do
    visit '/'

    click_link 'New Project'

    fill_in 'Name', with: 'Lawyer.ly'
    fill_in 'Description', with: 'A social network for lawyers'
    click_button 'Create Project'

    expect(page).to have_content('Project has been created.')

    project = Project.where(name: "Lawyer.ly").first

    expect(page.current_url).to eql(project_url(project))

    title = "Lawyer.ly - Projects - Project Tracker"

    expect(page).to have_title(title)

  end
end
