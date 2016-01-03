require 'rails_helper'

RSpec.describe "collects/edit", type: :view do
  before(:each) do
    @collect = assign(:collect, Collect.create!(
      :name => "MyString",
      :text => "MyString"
    ))
  end

  it "renders the edit collect form" do
    render

    assert_select "form[action=?][method=?]", collect_path(@collect), "post" do

      assert_select "input#collect_name[name=?]", "collect[name]"

      assert_select "input#collect_text[name=?]", "collect[text]"
    end
  end
end
