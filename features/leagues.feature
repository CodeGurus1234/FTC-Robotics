Feature: As a global administrator
I want to see all of the leagues in Iowa
So that I can have an overview

Scenario: As a global administrator I want to see all the leagues in Iowa


Given I am signed in as "Becca"

When I visit the leagues page

Then I should see all the leagues
