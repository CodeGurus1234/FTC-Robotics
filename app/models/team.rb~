class Team < ActiveRecord::Base  
#require 'smarter_csv' 
#require 'geokit'
validates :team, presence: true, :uniqueness => true

def self.upload(file)
    data = SmarterCSV.process(file)    

    data.each do |team|	
	#team[:geocoded_address] = Geokit::Geocoders::GoogleGeocoder3.geocode("#{team[:main_contact_postal_code]}")
	Team.create_team!(team)
    end
  end


  def self.create_team!(team)
  if team[:date_registered].nil?
  dateRegistered = (Time.now).strftime('%m/%d/%Y')
  else
  dateRegistered = DateTime.strptime(team[:date_registered], "%m/%d/%Y")
  end	
	Team.create!({:team => team[:team], :organization => team[:organization], :city=>team[:city], :state=>team[:state], :date_registered=> dateRegistered, :main_contact=>team[:main_contact], :main_contact_address=>team[:main_contact_address], :main_contact_city=>team[:main_contact_city], :"main_contact_state"=>team[:"main_contact_state/main_contact_prov"], :main_contact_postal_code=>team[:main_contact_postal_code], :country=>team[:country], :main_contact_email=>team[:main_contact_email], :main_contact_phone=>team[:"main_contact_phone/ext."], :county=>team[:county], :organization_type=>team[:organization_type],:school_district=>team[:school_district]})

end

def self.create_user!(team)
session_token=SecureRandom.base64
team_id = team[:team].to_s
email = team[:main_contact_email].to_s
 User.create! ( {:user_id => team_id, :email => email,  :role => 'Team_Member', :password => team_id, :session_token => session_token})
end

end
