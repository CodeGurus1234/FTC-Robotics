class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime :eventdate
      t.string :eventdesp
      t.string :teamsregistered
      t.string :eventlocation
      t.string :eventscope
      t.timestamps
    end
  end
end
