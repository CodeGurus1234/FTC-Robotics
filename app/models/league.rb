class League < ActiveRecord::Base
  attr_accessible :league_admin, :league_name, :team_no

def self.create_league!(teamnos,leagueName)
  League.create!({:league_name => leagueName , :team_no => teamnos})
end

end
