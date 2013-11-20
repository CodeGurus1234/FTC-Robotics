class SessionsController < ApplicationController
before_filter :set_current_user

def new
    # default: render 'new' template
end

def create
	@user = User.new(params[:user])
	exist= User.find_by_user_id(@user[:user_id] , :conditions => ["user_id = ?" , @user[:user_id]])
        userrole= exist.role
	if exist   
	   session[:session_token] = exist.session_token
           if exist.role == "Global_Admin"
            flash[:notice] = "Hi!! Becca You are on Global Admin Home Page"
	    redirect_to users_path
            end
           if exist.role == "Team_Member"
            flash[:notice] = "Hi!! #{@user.user_id} You are on your team's Home Page"
            redirect_to team_path(@user.user_id)
           end
	else
	   flash[:notice] = "Login/password combination"
	   redirect_to login_path	
        end   
end

def destroy
  session.clear
  redirect_to login_path
end

end	
  

