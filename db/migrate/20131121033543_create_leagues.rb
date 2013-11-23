class CreateLeagues < ActiveRecord::Migration
  def change
    create_table :leagues do |t|
      t.string :league_name
      t.string :team_no 
      t.string :league_admin
      t.timestamps
    end
  end
end
