class TeamsController < ApplicationController
before_filter :set_current_user

#require 'geokit-rails'

 def index
  @teams= Team.all  
 end
 def edit
 # default: render 'edit' template
 end
  def new
    # default: render 'new' template
  end
 def show
 # default: render 'show' template
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

def create_leagues
@teams_all= Team.all
 geo_hash= Hash.new()
 geo_hash = generate_geocoded_address(@teams_all)
   leagueNamesArray = ["applebot","kiwibot","bananabot","orangebot","raspbot","cherrybot","rubybot","pumpkinbot","grapebot","lemonbot","limebot"]
   i=-1
   # check from Leagues name already exist then do i++ TBD
   @teams_all.each do |team|       	
        @league = Array.new()
	 if team[:league_name] == nil and team[:main_contact_postal_code] !=nil
          i+=1
         @leagueName = leagueNamesArray[i] 
	 @league.push(team[:team])
	 team.update_attributes!(:league_name => @leagueName)
         team.save!
         League.create_league!(team[:team],@leagueName)
	 @centre = geo_hash[team[:team]]
	 @teams_all.each do |teamtest|
	   if @league.length < 16 
		    if teamtest[:league_name] == nil && teamtest[:main_contact_postal_code] !=nil && !@league.include?(teamtest[:team])
			      @test_if_in_radius = geo_hash[teamtest[:team]]
			      distance = @centre.distance_to(@test_if_in_radius)
			      if distance <50
					@league.push(teamtest[:team])
					teamtest.update_attributes!(:league_name => @leagueName)
					teamtest.save!
					League.create_league!(teamtest[:team],@leagueName)
			      end
		     end
            else
		break
            end            
          end #inner each ends
        end	
	#@leagues.push(@league)
    end #outer do ends

flash[:notice] = "Leagues--- #{@leagues}"
redirect_to teams_path	
end

def generate_geocoded_address(teams)
hash = Hash.new()
teams.each do |team|
  hash[team[:team]] = Geokit::Geocoders::GoogleGeocoder3.geocode("#{team[:main_contact_postal_code]}")
end
return hash
end


 def import  
  if(params[:file] == nil)
	flash[:notice] ="Sorry! No file selected. Please select a file and try again."
	redirect_to users_path
  else
       teams = Team.upload(params[:file].path) 
       @message = String.new ("Hi!!")    
       teams.each do |team|
	       if !(team.errors).empty?
		@message.concat("Sorry --#{team.team} was not added because of following erros #{team.errors.full_messages}.")
	       end
       end
        if @message.nil?
        flash[:notice] = "Team data Uploaded"
        redirect_to teams_path
        else
        flash[:notice] = "#{@message}.Please try again"
	redirect_to teams_path      
        end
  end
end

def update
    @team = Team.find params[:team]
    @team.update_attributes!(params[:team])
    flash[:notice] = "Profile was successfully updated."
    redirect_to team_path(@team)
  end

end
