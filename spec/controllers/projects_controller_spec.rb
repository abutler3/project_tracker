require 'spec_helper'

describe ProjectsController do
  let(:user) { FactoryGirl.create(:user) }
  before do
    sign_in(user)
  end

  it "displays an error for a missing project" do
    get :show, id: "not-here"

    expect(response).to redirect_to(projects_path)
    message = "The project you were looking for could not be found."

    expect(flash[:alert]).to eql(message)
  end

  context "standard users" do
    { new: :get,
      create: :post,
      edit: :get,
      update: :put,
      destroy: :delete }.each do |action, method|

      it "cannot access the #{action} action" do
        sign_in(user)

        send(method, action, :id => FactoryGirl.create(:project))

        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eql("You must be an admin to do that.")
      end
    end
  end

  it "cannot access the show action without permission" do
    project = FactoryGirl.create(:project)
    get :show, id: project.id

    expect(response).to redirect_to(projects_path)
    expect(flash[:alert]).to eql("The project you were looking for could not be found.")
  end
end
# require 'spec_helper'

# describe ProjectsController do
#   let(:user) { FactoryGirl.create(:user) }
#   # Set up a user
#   before do
#     sign_in(user)
#       # sign in with user created above
#   end

#     # test that you get reirected to Projects pages
#   # if you attempt to access a resource that no
#   # longer exists
#   it "displays an error for a missing project" do
#     get :show, id: "not-here"
#     # tells rspec a GET request to the show action
#     # for the ProjectsController
#     expect(response).to redirect_to(projects_path)
#     # tell rspec you expect the response to take you back
#     # to the projects_path through a redirect_to call
#     # if not, the test fails and nothing is done
#     message = "The project you were looking for could not be found."
#     expect(flash[:alert]).to eql(message)
#     # expect the flash[:alert] to contain a useful
#     # message explaning the redirection to the index
#   end
#   context "standard users" do
#     { new: :get,
#         create: :post,
#         edit: :get,
#         update: :put,
#         destroy: :delete }.each do |action,  method|

#     it "cannot access to the new action" do
#       sign_in(user)
#       # User makes a get request to the new action of the
#       # Projects Controller
#       send(method, action, :id => FactoryGirl.create(:project))
#       expect(response).to redirect_to(root_path)
#       # Response should redirect them to the root path of
#       # the application
#       expect(flash[:alert]).to eql("You must be an admin to do that.")
#       # Also should set a flash message to above.
#     end
#   end
# end

#   it "cannot access the show action without permission" do
#     project = FactoryGirl.create(:project)
#     get :show, id: project.id
#     expect(response).to redirect_to(projects_path)
#     message = "The project you were looking for could not be found."
#     expect(flash[:alert]).to eql(message)

#   end
# end
