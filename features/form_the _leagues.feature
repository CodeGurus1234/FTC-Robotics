Feature: In order to have the application generate leagues
I want the global admistrator to upload a csv file with teams, and it 
should generate leagues based on location after clicking the generate leagues button.

Scenario: Uploading a valid file with data for 3 new teams

  Given I am on the users page

  When I upload a file with valid data for 3 new teams

  Then I should see teams sorted in designated leagues
