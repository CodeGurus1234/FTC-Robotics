class TeamsController < ApplicationController
before_filter :set_current_user
 

require 'geokit-rails'


def index
 check_access_user
  @teams= Team.all    
end

def edit
 # default: render 'edit' template
end

def new
    # default: render 'new' template
end

def show
 @team_no = @current_user.user_id
 @eventsregistered = Eventregistration.find_all_by_team_no(@current_user.user_id)
end

def create
   @team = Team.create_team!(params[:team])
   @user = Team.create_user!(params[:team])
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
	redirect_to users_path
  else
       teams = Team.upload(params[:file].path) 
       @message = String.new   
       teams.each do |team|
	       if !(team.errors).empty?
		@message.concat("Sorry --#{team.team} was not added because of following erros #{team.errors.full_messages}.")
	       end
       end
        if @message.empty?
        flash[:notice] = "Team data Uploaded"	
	redirect_to teams_path 
        else
        flash[:notice] = "#{@message}.Please try again"
        redirect_to teams_path     
        end
  end
end
 
 def export
 send_data(Team.to_csv, :type => 'test/csv', :filename => 'teams.csv')
 end

def update
    @team = Team.find params[:team]
    @team.update_attributes!(params[:team])
    flash[:notice] = "Profile was successfully updated."
    redirect_to team_path(@team)
  end
end
