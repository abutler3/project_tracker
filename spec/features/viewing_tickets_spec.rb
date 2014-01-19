require 'spec_helper'

feature 'Viewing Tickets' do
  before do
    lawyerly_2 = FactoryGirl.create(:project, name: "Lawyerly 2")
    user = FactoryGirl.create(:user)

    ticket = FactoryGirl.create(:ticket, project: lawyerly_2, title: "Make it shiny!", description: "Gradients! Starburts! Oh my!")
    ticket.update(user: user)

    internet_explorer = FactoryGirl.create(:project, name: "Internet Explorer")
    FactoryGirl.create(:ticket,
            project: internet_explorer,
            title: "Standards compliance",
            description: "Isn't a joke")

    visit '/'
  end

  scenario "Visiting tickets for a given project" do
    click_link "Lawyerly 2"

    expect(page).to have_content("Make it shiny!")
    expect(page).to_not have_content("Standards compliance")

    click_link "Make it shiny!"
    within("#ticket h2") do
      expect(page).to have_content("Make it shiny!")
    end

    expect(page).to have_content("Gradients! Starburts! Oh my!")
  end
end
