class TeamsController < ApplicationController

 def index
  @teams= Team.all
 end


  def new
    # default: render 'new' template
  end
 def show
 # default: render 'show' template
end

 def create
   @team = Team.create_team!(params[:team])
   if @team.save
	flash[:notice] = "Welcome #{@team.team}. Your account has been created"
	redirect_to login_path	
  
   else
	flash[:notice] = " Sorry -- #{@team.errors.full_messages}.Try again"
	redirect_to new_team_path
   end
 end


 def import  
  if(params[:file] == nil)
	flash[:notice] ="Sorry! No file selected. Please select a file and try again."
	redirect_to teams_path
  else
       Team.upload(params[:file].path)  
       flash[:notice] = "Team data uploaded"
       redirect_to teams_path
  end

 
end


end
