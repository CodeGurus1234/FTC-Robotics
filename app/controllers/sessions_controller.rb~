class SessionsController < ApplicationController
before_filter :set_current_user

def new
    # default: render 'new' template
end

def create
	@team = Team.new(params[:team])
	exist= Team.find_by_team(@team[:team] , :conditions => ["team = ?" , @team[:team]])
	if exist   
	   session[:session_token] = exist.session_token
           if @user[:role]=='Global_Admin'
            flash[:notice] = "Hi!! Becca You are on Global Admin Home Page"
	    redirect_to teams_path
            end
           if @user[:role]=='Team_Member'
            flash[:notice] = "Hi!! #{@team.team} You are on your team's Home Page"
           end
	else
	   flash[:notice] = "Invalid team-number/password combination"
	   redirect_to login_path	
        end
end

def destroy
  session.clear
  redirect_to teams_path
end

end	
  

