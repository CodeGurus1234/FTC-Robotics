class UsersController < ApplicationController
before_filter :set_current_user 

def index
check_access_user 
  #default page
end

def create
 #default page
end

def show
@league = League.find_by_league_admin(params[:id])
@Leagueevents = Event.find_all_by_eventscope(@league[:league_name])
 #default page
end

end
