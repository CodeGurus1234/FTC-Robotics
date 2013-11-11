
Given /^I am on the login page$/ do
  visit login_path
  
 end

When /^I click "([^"]*)"$/ do |link|
  
  click_link (link)
end

Then /^I should see the Team Number field$/ do
  find_field('Team Number')
end
