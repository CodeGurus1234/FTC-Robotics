class LeaguesController < ApplicationController
  # GET /leagues
  # GET /leagues.json
  def index
    @leagues = League.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @leagues }
    end
  end

  # GET /leagues/1
  # GET /leagues/1.json
  def show
    @league = League.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @league }
    end
  end

  # GET /leagues/new
  # GET /leagues/new.json
  def new
    @league = League.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @league }
    end
  end

  # GET /leagues/1/edit
  def edit
    @league = League.find(params[:id])
  end

  # POST /leagues
  # POST /leagues.json
  
def create   
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
#if(team[:main_contact_postal_code] !=nil)
  hash[team[:team]] = Geokit::Geocoders::GoogleGeocoder3.geocode("#{team[:main_contact_postal_code]}")
#end
end
return hash
end


  # PUT /leagues/1
  # PUT /leagues/1.json
  def update
    @league = League.find(params[:id])

    respond_to do |format|
      if @league.update_attributes(params[:league])
        format.html { redirect_to @league, notice: 'League was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @league.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leagues/1
  # DELETE /leagues/1.json
  def destroy
    @league = League.find(params[:id])
    @league.destroy

    respond_to do |format|
      format.html { redirect_to leagues_url }
      format.json { head :no_content }
    end
  end
end
