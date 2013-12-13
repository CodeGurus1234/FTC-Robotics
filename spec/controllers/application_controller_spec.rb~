require 'spec_helper'

describe ApplicationController do
 describe "set_current_user" do
    it "sets the current users" do
    end
  end
describe "check_access_user_global" do
   it "checks global access" do
  if @current_user.nil?
   expect(response).to redirect_to(login_path)
   flash[:notice].should == "Please Login first"
   else 
   if @current_user.user_id != "Becca"
	  	flash[:notice].should == "Sorry!! You are not allowed to see this page"
	     if @current_user.role == 'League_Admin'
	  	expect(response).to redirect_to(user_path), :id => @current_user.user_id
	     end
	     if @current_user.role == 'Team_Member'
	  	expect(response).to redirect_to(team_path), :id => @current_user.user_id
	     end
          end
   end
 end
end
   
end

