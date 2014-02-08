require 'spec_helper'

describe TicketsController do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:project) { FactoryGirl.create(:project) }
  let!(:ticket) { FactoryGirl.create(:ticket, project: project, user: user) }

  context "standard users" do
    it "cannot access a ticket for a project" do
      sign_in(user)
      get :show, :id => ticket.id, :project_id => project.id
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eql("The project you were looking for could not be found.")
    end

    context "with permission to view the project" do
      before do
        sign_in(user)
        define_permission!(user, "view", project)
      end

      def cannot_create_tickets!
        response.should redirect_to(project)
        message = "You cannot create tickets on this project."
        flash[:alert].should eql(message)
      end

      def cannot_update_tickets!
        expect(response).to redirect_to(project)
        expect(flash[:alert]).to eql("You cannot edit tickets on this project.")
      end

      it "cannot begin to create a ticket" do
        get :new, project_id: project.id
        cannot_create_tickets!
      end

      it "cannot create a ticket without permission" do
        post :create, project_id: project.id
        cannot_create_tickets!
      end

      it "cannot edit a ticket without permission" do
        get :edit, { project_id: project.id, id: ticket.id }
        # I need to pass a project_id parameter so the set_project
        # method can find a project and an id parameter so the
        # set_ticket method can find a ticket
        cannot_update_tickets!
      end

      it "cannot update a ticket without permission" do
        put :update, { project_id: project.id, id: ticket.id, ticket: {} }
        # the empty hash is so the params[:ticket] is set
        cannot_update_tickets!
      end

      it "cannot delete a ticket without permission" do
        delete :destroy, { project_id: project.id, id: ticket.id }
        # the empty hash is so the params[:ticket] is set
        expect(response).to redirect_to(project)
        expect(flash[:alert]).to eql("You cannot delete tickets from this project.")
      end
    end
  end
end
