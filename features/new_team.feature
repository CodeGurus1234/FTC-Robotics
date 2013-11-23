Feature: In order to allow new teams to sign up
I want them to be able to fill out a form of their team information, and it should show up in the database.

Scenario:
  Given I am on the Sign-up page

  
  When I fill in "4444" for "team_team"
  And I fill in "Columbia" for "team_organization"
  And I fill in "Johnson" for "team_school_district"
  And I fill in "Chicago" for "team_state"
  And I fill in "Massachussetes" for "team_state"
  And I fill in "Johnson" for "team_county"
  And I fill in "Jay Z" for "team_main_contact"
  And I fill in "Santa Monica Blvd" for "team_main_contact_address"
  And I fill in "Los Angeles" for "team_main_contact_city"
  And I fill in "jayz@yahoo.com" for "team_main_contact_email"
  And I fill in "630-209-4505" for "team_main_contact_phone/ext."
  When I press "Create Team"


  Then I should see the account has been created
