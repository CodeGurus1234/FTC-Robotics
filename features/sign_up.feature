Feature: In order to allow new teams to sign up
I want to give them the option to sign up at the login page

Scenario:
  Given I am on the login page

  When I click "Sign-up as a new team"

  Then I should see the Team Number field
