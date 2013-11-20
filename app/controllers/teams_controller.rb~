class TeamsController < ApplicationController

 def index
  @teams= Team.all  
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


 def import  
  if(params[:file] == nil)
	flash[:notice] ="Sorry! No file selected. Please select a file and try again."
	redirect_to teams_path
  else
       Team.upload(params[:file].path)  
       flash[:notice] = "Team data uploaded"
       redirect_to teams_path
  end
end


def create_leagues
@league1 = Array.new()
  @teams = Team.find_by_id('16')
  @teams_all = Team.all
   #@teams.each do |team|
	if @teams[:league_name] == nil and @teams[:main_contact_postal_code] !=nil
	 @league1.push(@teams[:team])
	 @teams[:league_name] = "league1"
	 @centre = Geokit::Geocoders::GoogleGeocoder3.geocode(@teams[:main_contact_postal_code])
	 @teams_all.each do |teamtest| 
	   if @league1.length < 16
           if teamtest[:league_name] == nil && teamtest[:main_contact_postal_code] !=nil && !@league1.include?(teamtest[:team])
	    @test_if_in_radius = Geokit::Geocoders::GoogleGeocoder3.geocode("#{teamtest[:main_contact_postal_code]}")
	    distance = @centre.distance_to(@test_if_in_radius)
	    if distance <50
		@league1.push(teamtest[:team])
	        teamtest[:league_name] = "league1"	    
	    end
	   end
	   end
         end
 	end	
   #end
flash[:notice] = "Hiee.. #{@league1}"
redirect_to teams_path	
end

def test_create_leagues
i =0 
@league_array = Array.new()
@teams_all = Team.all
@teams = Team.all
   @teams.each do |currentteam|
	i+=1
	@league_i = Array.new()
	if currentteam[:league_name] == nil && currentteam[:main_contact_postal_code] !=nil
	 @league_i.push(currentteam[:team])
	 currentteam[:league_name] = "league_" + i
	 @centre = Geokit::Geocoders::GoogleGeocoder3.geocode("#{currentteam[:main_contact_postal_code]}")
	 @teams_all.each do |teamtest| 
	   if @league_i.length < 16
           if teamtest[:league_name] == nil && teamtest[:main_contact_postal_code] !=nil && !@league_i.include?(teamtest[:team])
	    @test_if_in_radius = Geokit::Geocoders::GoogleGeocoder3.geocode("#{teamtest[:main_contact_postal_code]}")
	    distance = @centre.distance_to(@test_if_in_radius)
	    if distance <50
		@league_i.push(teamtest[:team])
	        teamtest[:league_name] = "league_"+i	    
	    end
	   end
	   else
		#i+=1
		break
	   end
         end    #teams_all ended
	 else
	   break
 	end	#if @teams[:league_name] == nil ended
@league_array.push(@league_i)
	end     #teams ended
flash[:notice] = "#{@league_array}"
redirect_to teams_path
end

end
