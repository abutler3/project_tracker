require 'spec_helper'

# feature 'Editing Projects' do
#   scenario "Updating a project" do
#     FactoryGirl.create(:project, name: "Lawyer.ly")

#     visit '/'
#     click_link 'Lawyer.ly'
#     click_link 'Edit Project'
#     fill_in "Name", with: "Lawyer.ly beta 2.0"
#     click_button "Update Project"
#     expect(page).to have_content("Project has been updated.")
#   end
# end

feature 'Editing Projects' do
  before do
    FactoryGirl.create(:project, name: "Lawyer.ly")
    visit '/'
    click_link 'Lawyer.ly'
    click_link 'Edit Project'
  end

  scenario "Updating a project" do
    fill_in "Name", with: "Lawyer.ly beta 2.0"
    click_button "Update Project"

    expect(page).to have_content("Project has been updated.")
  end

  scenario "Updating a project with invalid attibutes is bad" do
    fill_in "Name", with: ""
    click_button "Update Project"

    expect(page).to have_content("Project has not been updated.")

  end
end

