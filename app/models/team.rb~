class Team < ActiveRecord::Base  
#require 'smarter_csv' 
#require 'geokit'
validates :team, presence: true, :uniqueness => true
validates :team, :format => { :with => /\d{4}/, :message => "Only 4 digit numbers allowed"}
validates :state, :format => { :with => /\A[a-zA-Z]+\z/, :message => "Only letters allowed" }
validates :city, :format => { :with => /\A[a-z A-Z]+\z/, :message => "Only letters allowed" }
validates :county, :format => { :with => /\A[a-zA-Z]+\z/, :message => "Only letters allowed" }
validates :country, :format => { :with => /\A[a-zA-Z]+\z/, :message => "Only letters allowed" }
validates :main_contact, :format => { :with => /\A.*[a-zA-Z]+\z/, :message => "Only letters allowed" }
validates :main_contact_city, :format => { :with => /\A[a-z A-Z]+\z/, :message => "Only letters allowed" }
validates :main_contact_postal_code, :format => { :with => /^\d{5}(-\d{4})?$/, :message => "Only 5 digit numbers like XXXXX or 9 digit numbers like xxxxx-xxxx allowed" }
validates :main_contact_phone, :format => { :with => /^\(\d{3}\) ?\d{3}( |-)?\d{4}|^\d{3}( |-)?\d{3}( |-)?\d{4}/, :message => "Only  digit numbers like XXXXXXXXXX or xxx-xxx-xxxx or (xxx)xxx-xxxx allowed" }
validates :main_contact_email, :format => { :with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/, :message => "Only valid email address formats allowed" }


def self.upload(file)
    data = SmarterCSV.process(file)    
    @teams = Array.new()
    data.each do |team|	
	#team[:geocoded_address] = Geokit::Geocoders::GoogleGeocoder3.geocode("#{team[:main_contact_postal_code]}")
	@team = Team.create_team!(team)
        @teams.push(@team)
    end
     return @teams   
  end


  def self.create_team!(team)
  if team[:date_registered].nil?
  dateRegistered = (Time.now).strftime('%m/%d/%Y')
  else
  dateRegistered = DateTime.strptime(team[:date_registered], "%m/%d/%Y")
  end	
Team.create({:team => team[:team], :organization => team[:organization], :city=>team[:city], :state=>team[:state], :date_registered=> dateRegistered, :main_contact=>team[:main_contact], :main_contact_address=>team[:main_contact_address], :main_contact_city=>team[:main_contact_city], :"main_contact_state"=>team[:"main_contact_state/main_contact_prov"], :main_contact_postal_code=>team[:main_contact_postal_code], :country=>team[:country], :main_contact_email=>team[:main_contact_email], :main_contact_phone=>team[:"main_contact_phone/ext."], :county=>team[:county], :organization_type=>team[:organization_type],:school_district=>team[:school_district]})
end

def self.create_user!(team)
session_token=SecureRandom.base64
team_id = team[:team].to_s
email = team[:main_contact_email].to_s
 User.create ( {:user_id => team_id, :email => email,  :role => 'Team_Member', :password => team_id, :session_token => session_token})
end

end
