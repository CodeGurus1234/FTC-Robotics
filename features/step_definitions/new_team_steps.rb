Given /^I am on the Sign-up page$/ do
  visit new_team_path
 end

Then /^I should see the account has been created$/ do

  visit login_path
end


Given /^I am on the teams page$/ do
  visit teams_path



 end
Then /^I should see the teams added$/ do

  visit teams_path
end


When /^I upload a file with valid data for 3 new teams$/ do
  visit teams_path
 

end
