class League < ActiveRecord::Base
  attr_accessible :league_admin, :league_name, :team_no

def self.create_league!(teamnos,leagueName)
  League.create!({:league_name => leagueName , :team_no => teamnos})
end

 def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |league|
        csv << league.attributes.values_at(*column_names)
      end
   end
end

end
