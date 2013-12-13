class Event < ActiveRecord::Base
  # attr_accessible :title, :body
 
def self.find_Events(team)
   leagueevents = Event.find_all_by_eventscope(team[:league_name]) 
   globalevents = Event.find_all_by_eventscope('Global Event')
   return leagueevents.push(globalevents)
   return leagueevents
end
end
