require 'spec_helper'

describe ProjectsController do
  let(:user) { FactoryGirl.create(:user) }
  # Set up a user
  context "standard users" do
    before do
      sign_in(user)
      # sign in with user created above
    end

    it "cannot access to the new action" do
      get :new
      # User makes a get request to the new action of the
      # Projects Controller
      expect(response).to redirect_to('/')
      # Response should redirect them to the root path of
      # the application
      expect(flash[:alert]).to eql("You must be an admin to do that.")
      # Also should set a flash message to above.
    end
  end

  # test that you get reirected to Projects pages
  # if you attempt to access a resource that no
  # longer exists
  it "displays an error for a missing project" do
    get :show, id: "not-here"
    # tells rspec a GET request to the show action
    # for the ProjectsController
    expect(response).to redirect_to(projects_path)
    # tell rspec you expect the response to take you back
    # to the projects_path through a redirect_to call
    # if not, the test fails and nothing is done
    message = "The project you were looking for could not be found."
    expect(flash[:alert]).to eql(message)
    # expect the flash[:alert] to contain a useful
    # message explaning the redirection to the index
  end

end
