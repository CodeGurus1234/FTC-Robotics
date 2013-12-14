class UsersController < ApplicationController
before_filter :set_current_user 

def index
  check_access_user_global 
  #default page
end

def create
 #default page
end

def show
 check_access_user_Admins
 @league = League.find_by_league_admin(params[:id])
 #default page
end

end
