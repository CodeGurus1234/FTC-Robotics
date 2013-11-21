class UsersController < ApplicationController
before_filter :set_current_user
def index
  #default page
 end
def create
  #@team = Team.create_team!(params[:user])
  @user = User.create_user!(params[:user])
 if @user.save
 redirect_to login_path
end
  #default page
 end
def create_leagues
end
end
