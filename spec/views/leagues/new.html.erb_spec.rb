require 'spec_helper'

describe "leagues/new" do
  before(:each) do
    assign(:league, stub_model(League,
      :league_name => "MyString",
      :team_no => 1,
      :league_admin => "MyString"
    ).as_new_record)
  end

  it "renders new league form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", leagues_path, "post" do
      assert_select "input#league_league_name[name=?]", "league[league_name]"
      assert_select "input#league_team_no[name=?]", "league[team_no]"
      assert_select "input#league_league_admin[name=?]", "league[league_admin]"
    end
  end
end
