class TeamsController < ApplicationController
before_filter :set_current_user
 

require 'geokit-rails'


def index
  check_access_user_global
  @teams= Team.all    
end

def edit
@team = Team.find_by_team(@current_user.user_id)
 # default: render 'edit' templat
end

def new
    # default: render 'new' template
end

def show
 check_access_user_Team(params[:id])
 @team_no = @current_user.user_id
 #@team_info = Team.find_by_team(@team_no)
 #if @team_info[:city] == nil
  #flash[:notice] = "Please fill up all the details before continuing. #{@team_info[:city]}"
 # redirect_to teams_first_login_path
 #else 
#end
 @eventsregistered = Eventregistration.find_all_by_team_no(@current_user.user_id)
#end
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
    @team =Team.update_att(params)
    #@team = Team.find_by_team(@current_user.user_id)
    #@team.update_attributes!(params[:team])
    if @team.to_s == "true"
      flash[:notice] = "Profile was successfully updated. "
      redirect_to team_path(@current_user.user_id)
   else
	flash[:notice] = " Sorry -- #{@team.errors.full_messages}.Try again"
	redirect_to edit_team_path(@current_user.user_id)

    end

end
end
