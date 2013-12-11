class ApplicationController < ActionController::Base
  protect_from_forgery
def set_current_user
  @current_user||=session[:session_token]&&
			 User.find_by_session_token(session[:session_token])
end

def check_access_user_global
 if @current_user.nil?
   flash[:notice] ="Please Login first"
   redirect_to login_path
  else
	  if @current_user.user_id != "Becca"
	  	flash[:notice] ="Sorry!! You are not allowed to see this page"
	     if @current_user.role == 'League_Admin'
	  	redirect_to user_path :id => @current_user.user_id
	     end
	     if @current_user.role == 'Team_Member'
	  	redirect_to team_path :id => @current_user.user_id
	     end
          end
  end
end

def check_access_user_Admins
 if @current_user.nil?
   flash[:notice] ="Please Login first"
   redirect_to login_path
  else
	  if @current_user.role == "Team_Member"
	  	flash[:notice] ="Sorry!! You are not allowed to see this page"
	  	redirect_to team_path :id => @current_user.user_id
	  end
  end
end

def check_access_user_Team(team)
 if @current_user.nil?
   flash[:notice] ="Please Login first"
   redirect_to login_path
  else
	  if @current_user.role != "Team_Member"
	  	flash[:notice] ="Sorry!! Only teams are allowed to view their page"
	     if @current_user.role == "League_Admin"
	  	redirect_to user_path :id => @current_user.user_id
	     end
	     if @current_user.user_id == "Becca"
	  	redirect_to users_path
	     end
           else 
             if @current_user.user_id != team
              flash[:notice] ="Sorry!! You are not allowed to see other teams page!!"
              redirect_to team_path :id => @current_user.user_id
            end
           end
  end
end

end
