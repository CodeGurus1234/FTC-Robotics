class Team < ActiveRecord::Base 

#require 'smarter_csv' 
#require 'geokit'

validates :team, :presence => true, :uniqueness => true, :format => { :with => /^\d{4}$/, :message => "Only 4 digit numbers allowed"}, :on=> :create
validates :main_contact, :format => { :with => /\A.*[a-z A-Z]+\z/, :message => "Only letters allowed" },:on=> :create
validates :main_contact_email, :format => { :with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/, :message => "Only valid email address formats allowed" },:on=> :create


validates :school_district, :presence => true, :on=>:update
validates :organization_type, :presence => true, :on=>:update
validates :state,:presence => true, :format => { :with => /\A[a-z A-Z]+\z/, :message => "Only letters allowed" },:on=>:update
validates :city, :presence => true,:format => { :with => /\A[a-z A-Z]+\z/, :message => "Only letters allowed" },:on=>:update
validates :county,:presence => true, :format => { :with => /\A[a-z A-Z]+\z/, :message => "Only letters allowed" },:on=>:update
validates :country,:presence => true, :format => { :with => /\A[a-z A-Z]+\z/, :message => "Only letters allowed" },:on=>:update
validates :main_contact_city, :presence => true,:on=>:update #:format => { :with => /\A.*[a-z A-Z]+\z/, :message => "Only letters allowed" }
validates :main_contact_postal_code, :presence => true,:format => { :with => /^\d{5}(-\d{4})?$/, :message => "Only 5 digit numbers like XXXXX or 9 digit numbers like xxxxx-xxxx allowed" },:on=>:update
validates :main_contact_phone, :presence => true,:format => { :with => /^\(\d{3}\) ?\d{3}( |-)?\d{4}|^\d{3}( |-)?\d{3}( |-)?\d{4}/, :message => "Only  digit numbers like XXXXXXXXXX or xxx-xxx-xxxx or (xxx)xxx-xxxx allowed" },:on=>:update



def self.upload(file)
    data = SmarterCSV.process(file)    
    @teams = Array.new()
    data.each do |team|	
	#team[:geocoded_address] = Geokit::Geocoders::GoogleGeocoder3.geocode("#{team[:main_contact_postal_code]}")
	@team = Team.create_team!(team)
        @teams.push(@team)
	create_user!(team)
    end
     return @teams   
end

 def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |team|
        csv << team.attributes.values_at(*column_names)
      end
    end
  end


def self.create_team!(team)
  if team[:date_registered].nil?
  dateRegistered = Time.now #).strftime('%m/%d/%Y')
  else
  dateRegistered = DateTime.strptime(team[:date_registered], "%m/%d/%Y")
  end	
Team.create({:team => team[:team], :date_registered=>dateRegistered, :main_contact=>team[:main_contact], :main_contact_address=> team[:main_contact_address],:main_contact_city=> team[:main_contact_city],:main_contact_state=> team[:main_contact_state], :main_contact_postal_code=> team[:main_contact_postal_code], :main_contact_email=>team[:main_contact_email],:country=> team[:country],:organization => team[:organization], :city=>team[:city], :state=>team[:state],  :main_contact_phone=>team[:"main_contact_phone"], :county=>team[:county], :organization_type=>team[:organization_type],:school_district=>team[:school_district]})
end


def self.create_user!(team)
session_token=SecureRandom.base64
team_id = team[:team].to_s
email = team[:main_contact_email].to_s
 user = User.create!( {:user_id => team_id, :email => email, :role => 'Team_Member', :password => team_id, :session_token => session_token})
user.save

end

def self.update_att(team)
    Team.update(team[:id],team[:team])
end

end
