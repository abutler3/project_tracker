require 'spec_helper'

feature 'Creating Projects' do
  scenario "Listing all projects" do
    project = FactoryGirl.create(:project, name: "Lawyer.ly")
    visit '/'
    click_link 'Lawyer.ly'
    expect(page.current_url).to eql(project_url(project))
  end
end
