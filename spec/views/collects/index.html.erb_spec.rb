require 'rails_helper'

RSpec.describe "collects/index", type: :view do
  before(:each) do
    assign(:collects, [
      Collect.create!(
        :name => "Name",
        :text => "Text"
      ),
      Collect.create!(
        :name => "Name",
        :text => "Text"
      )
    ])
  end

  it "renders a list of collects" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Text".to_s, :count => 2
  end
end
