require 'spec_helper'

describe "leagues/edit" do
  before(:each) do
    @league = assign(:league, stub_model(League,
      :league_name => "MyString",
      :team_no => 1,
      :league_admin => "MyString"
    ))
  end

  it "renders the edit league form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", league_path(@league), "post" do
      assert_select "input#league_league_name[name=?]", "league[league_name]"
      assert_select "input#league_team_no[name=?]", "league[team_no]"
      assert_select "input#league_league_admin[name=?]", "league[league_admin]"
    end
  end
end
