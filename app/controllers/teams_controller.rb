class TeamsController < ApplicationController

 def index
  @teams= Team.all
 end


  def new
    # default: render 'new' template
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
  #Team.import(params[:file])
  data = SmarterCSV.process(params[:file].path) 
  data.each do |row|
  Team.create!(row)
 end
  redirect_to teams_path, notice: "CSV imported."
end


end
