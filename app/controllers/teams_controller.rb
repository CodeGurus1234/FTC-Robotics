class TeamsController < ApplicationController
 def index
  @teams= Team.all
 end

 def upload
  Team.upload(params[:file].path)  
  flash[:notice] = "Team data uploaded"
  redirect_to teams_path
 end

 def new
 end
end
