class CreateTeams < ActiveRecord::Migration
  def up
    create_table :teams do |t|
	t.integer :team
	t.text :organization
	t.string :city
	t.string :state
	t.datetime :date_registered
	t.string :main_contact
	t.string :main_contact_address
	t.string :main_contact_city
	t.string :main_contact_state
	t.string :main_contact_postal_code
	t.string :country
	t.string :main_contact_email
	t.string :main_contact_phone
	t.string :county
	t.string :organization_type
	t.string :school_district
      t.timestamps
    end
  end

def down
drop_table :teams
end

end
