require 'spec_helper'

describe TeamsController do
  let(:valid_attributes) { { :organization => "MyString" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # TeamsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all teams as @teams" do
      team = Team.create! valid_attributes
      get :index, {}, valid_session
      assigns(:teams).should eq([team])
    end
  end

  describe "GET show" do
    it "assigns the requested team as @team" do
      team = Team.create! valid_attributes
      get :show, {:id => team.to_param}, valid_session
      assigns(:team).should eq(team)
    end
  end

  describe "GET new" do
    it "assigns a new team as @team" do
      get :new, {}, valid_session
      assigns(:team).should be_a_new(Team)
    end
  end

  describe "GET edit" do
    it "assigns the requested team as @team" do
      team = Team.create! valid_attributes
      get :edit, {:id => team.to_param}, valid_session
      assigns(:team).should eq(team)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Team" do
        expect {
          post :create, {:team => valid_attributes}, valid_session
        }.to change(Team, :count).by(1)
      end

      it "assigns a newly created team as @team" do
        post :create, {:team => valid_attributes}, valid_session
        assigns(:team).should be_a(Team)
        assigns(:team).should be_persisted
      end

      it "redirects to the created team" do
        post :create, {:team => valid_attributes}, valid_session
        response.should redirect_to(Team.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved team as @team" do
        # Trigger the behavior that occurs when invalid params are submitted
        Team.any_instance.stub(:save).and_return(false)
        post :create, {:team => { "organization" => "invalid value" }}, valid_session
        assigns(:team).should be_a_new(Team)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Team.any_instance.stub(:save).and_return(false)
        post :create, {:team => { "organization" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested team" do
        team = Team.create! valid_attributes
        # Assuming there are no other teams in the database, this
        # specifies that the Team created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Team.any_instance.should_receive(:update_attributes).with({ "organization" => "MyString" })
        put :update, {:id => team.to_param, :team => { "organization" => "MyString" }}, valid_session
      end

      it "assigns the requested team as @team" do
        team = Team.create! valid_attributes
        put :update, {:id => team.to_param, :team => valid_attributes}, valid_session
        assigns(:team).should eq(team)
      end

      it "redirects to the team" do
        team = Team.create! valid_attributes
        put :update, {:id => team.to_param, :team => valid_attributes}, valid_session
        response.should redirect_to(team)
      end
    end

    describe "with invalid params" do
      it "assigns the team as @team" do
        team = Team.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Team.any_instance.stub(:save).and_return(false)
        put :update, {:id => team.to_param, :team => { "organization" => "invalid value" }}, valid_session
        assigns(:team).should eq(team)
      end

      it "re-renders the 'edit' template" do
        team = Team.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Team.any_instance.stub(:save).and_return(false)
        put :update, {:id => team.to_param, :team => { "organization" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested team" do
      team = Team.create! valid_attributes
      expect {
        delete :destroy, {:id => team.to_param}, valid_session
      }.to change(Team, :count).by(-1)
    end

    it "redirects to the teams list" do
      team = Team.create! valid_attributes
      delete :destroy, {:id => team.to_param}, valid_session
      response.should redirect_to(teams_url)
    end
  end

  describe 'CSV import failure' do
    after :each do
       response.should redirect_to teams_path
    end
    it 'should return to teams_path with bad file' do
       post :import, {:file => nil}
    end
  end

  describe 'CSV import' do
     after :each do
       response.should redirect_to teams_path
     end
     it 'Should return to teams_path if csv upload works' do 
       post :import, {:file => nil} #remember to add file to this later
     end
  end

  
end
