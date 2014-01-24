require 'spec_helper'

describe Admin::UsersController do
  let(:user) { FactoryGirl.create(:user) }
  # Create a new user called user

  context "standard users" do
    before { sign_in(user) }
    # Sign in using the sign_in method in the AuthHelpers module
    it "are not able to access the index action" do
      get 'index'
      # attempt a GET request to the index action
      expect(response).to redirect_to('/')
      # redirect to root path
      expect(flash[:alert]).to eql("You must be an admin to do that.")
      # Should see flash alert
    end
  end
end
