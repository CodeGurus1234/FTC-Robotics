class User < ActiveRecord::Base
  # attr_accessible :title, :body
def self.create_leagueAdmin!(leagueAdminInfo)
  session_token=SecureRandom.base64
  User.create! ( {:user_id => leagueAdminInfo[:main_contact], :email => leagueAdminInfo[:main_contact_email],  :role => 'League_Admin', :password_digest => leagueAdminInfo[:main_contact],  :session_token => session_token, :updatedProfile => 'no'})
end

end
