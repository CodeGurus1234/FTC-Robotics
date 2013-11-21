require 'spec_helper'

describe "leagues/index" do
  before(:each) do
    assign(:leagues, [
      stub_model(League,
        :league_name => "League Name",
        :team_no => 1,
        :league_admin => "League Admin"
      ),
      stub_model(League,
        :league_name => "League Name",
        :team_no => 1,
        :league_admin => "League Admin"
      )
    ])
  end

  it "renders a list of leagues" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "League Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "League Admin".to_s, :count => 2
  end
end
