require 'spec_helper'

feature 'hidden links' do
  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin_user) }
  let(:project) { FactoryGirl.create(:project) }
  let(:ticket) { FactoryGirl.create(:ticket, project: project, user: user) }
  # Let blocks for user and admin

  context "anonymous users" do
    scenario "cannot see the New Project link" do
      visit '/'
      assert_no_link_for "New Project"
    end
    scenario "cannot see the Edit Project link" do
      visit project_path(project)
      assert_no_link_for "Edit Project"
    end
    scenario "cannot see the Delete Project link" do
      visit project_path(project)
      assert_no_link_for "Delete Project"
    end
  end

  context "regular users" do
    before { sign_in_as!(user) }
    scenario "cannot see the New Project link" do
      visit '/'
      assert_no_link_for "New Project"
    end
    scenario "cannot see the Edit Project link" do
      visit project_path(project)
      assert_no_link_for "Edit Project"
    end
    scenario "cannot see the Delete Project link" do
      visit project_path(project)
      assert_no_link_for "Delete Project"
    end
    scenario "New Ticket link is shown to a user with permission" do
      define_permission!(user, "view", project)
      # User has permission to view project
      define_permission!(user, "create tickets", project)
      # user has permission to create tickets for project
      visit project_path(project)
      # They should be about to go to the project
      assert_link_for "New Ticket"
      # And view this link
    end
    scenario "New Ticket link is hidden from a user without permission" do
      define_permission!(user, "view", project)
      # User has permission to view project
      # No permission to create ticket
      visit project_path(project)
      # They should be about to go to the project
      assert_no_link_for "New Ticket"
      # And not view this link
    end

    scenario "Edit Ticket link is shown to a user with permission" do
      ticket
      define_permission!(user, "view", project)
      # User has permission to view project
      # No permission to create ticket
      define_permission!(user, "edit tickets", project)
      visit project_path(project)
      # They should be about to go to the project
      click_link ticket.title
      assert_link_for "Edit Ticket"
      # And view this link
    end
    scenario "Edit Ticket link is shown to a user with permission" do
      ticket
      define_permission!(user, "view", project)
      # User has permission to view project
      # No permission to create ticket
      visit project_path(project)
      # They should be about to go to the project
      click_link ticket.title
      assert_no_link_for "Edit Ticket"
      # And view this link
    end
    scenario "Delete Ticket link is shown to a user with permission" do
      ticket
      define_permission!(user, "view", project)
      # User has permission to view project
      # No permission to create ticket
      define_permission!(user, "delete tickets", project)
      visit project_path(project)
      # They should be about to go to the project
      click_link ticket.title
      assert_link_for "Delete Ticket"
      # And view this link
    end
    scenario "Delete Ticket link is hidden from user with permission" do
      ticket
      define_permission!(user, "view", project)
      # User has permission to view project
      # No permission to create ticket
      visit project_path(project)
      # They should be about to go to the project
      click_link ticket.title
      assert_no_link_for "Delete Ticket"
      # And view this link
    end
  end

  context "admin users" do
    before { sign_in_as!(admin) }
    scenario "can see the New Project link" do
      visit '/'
      assert_link_for "New Project"
    end
    scenario "can see the Edit Project link" do
      visit project_path(project)
      assert_link_for "Edit Project"
    end
    scenario "can see the Delete Project link" do
      visit project_path(project)
      assert_link_for "Delete Project"
    end
    scenario "New ticket link is shown to admins" do
      visit project_path(project)
      assert_link_for "New Ticket"
    end
    scenario "Edit Ticket link is shown to admins" do
      ticket
      visit project_path(project)
      # They should be about to go to the project
      click_link ticket.title
      assert_link_for "Edit Ticket"
      # And view this link
    end
    scenario "Delete Ticket link is shown to admins" do
      ticket
      visit project_path(project)
      # They should be about to go to the project
      click_link ticket.title
      assert_link_for "Delete Ticket"
      # And view this link
    end
  end
end
