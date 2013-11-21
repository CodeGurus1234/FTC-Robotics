class TeamsController < ApplicationController
before_filter :set_current_user
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
   @user = User.create_user!(params[:team])
   if @team.save
	flash[:notice] = "Welcome #{@team.team}. Your account has been created"
	redirect_to login_path	
  
   else
	flash[:notice] = " Sorry -- #{@team.errors.full_messages}.Try again"
	redirect_to new_team_path
   end
 end

def create_leagues
#@league1 = Array.new()
 # @teams = Team.find_by_id('16')
  @teams_all = Team.all
   leagueNamesArray = ["applebot","kiwibot","bananabot","orangebot","raspbot","cherrybot","rubybot","pumpkinbot","grapebot","lemonbot","limebot"]
   i=0
   # check from Leagues name already exist then do i++ TBD
   @teams_all.each do |team| 
        @leagues = Array.new()
        @leagueName = leagueNamesArray[i]  
	#leagueNamesArray[i] = Array.new()
        @league = Array.new()
	if team[:league_name] == nil and team[:main_contact_postal_code] !=nil
	 @league.push(team[:team])
	 team.update_attributes!(:league_name => @leagueName)
         team.save!
	 @centre = Geokit::Geocoders::GoogleGeocoder3.geocode(team[:main_contact_postal_code])
	 @teams_all.each do |teamtest| 
		    if teamtest[:league_name] == nil && teamtest[:main_contact_postal_code] !=nil && !@league.include?(teamtest[:team])
			      @test_if_in_radius = Geokit::Geocoders::GoogleGeocoder3.geocode("#{teamtest[:main_contact_postal_code]}")
			      distance = @centre.distance_to(@test_if_in_radius)
			      if distance <50
                                  if @league.length < 16
					@league.push(teamtest[:team])
					teamtest.update_attributes!(:league_name => @leagueName)
	                          else
			                @leagues.push(@league) # Push in leagues table TBD
			                 i=i+1
			                break
			          end
			      end
		     end
            
          end #inner each ends
        end	
    end #outer do ends
#puts @leagues
redirect_to teams_path	
end

 def import  
  if(params[:file] == nil)
	flash[:notice] ="Sorry! No file selected. Please select a file and try again."
	redirect_to users_path
  else
       team = Team.upload(params[:file].path)
       if team.nil?
        flash[:notice] = "Team data uploaded"
        redirect_to teams_path
       else
        flash[:notice] = " Sorry -- #{team.errors.full_messages}.Try again"
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
