class League < ActiveRecord::Base
  attr_accessible :league_admin, :league_name, :team_no

def self.create_league!(league,leagueName)
leagues.each do |team|
League.create!({:league_name => leagueName , :team_no => team[:team]})
#League.create!({:league_name => 'trialbot', :team_no => '1111', :league_admin => 'abc'})
end
end
end
