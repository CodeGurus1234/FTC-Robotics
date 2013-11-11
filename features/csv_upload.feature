 Feature: CSV file upload
    In order to create new teams in the database
    As a global administrator
    I want to be able to upload a CSV file with the products' data

    Scenario: Uploading a valid file with data for 3 new teams
      Given I am on the teams page
      When I upload a file with valid data for 3 new teams
      Then I should see the teams added
