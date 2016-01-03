require 'rails_helper'

RSpec.describe "collects/new", type: :view do
  before(:each) do
    assign(:collect, Collect.new(
      :name => "MyString",
      :text => "MyString"
    ))
  end

  it "renders new collect form" do
    render

    assert_select "form[action=?][method=?]", collects_path, "post" do

      assert_select "input#collect_name[name=?]", "collect[name]"

      assert_select "input#collect_text[name=?]", "collect[text]"
    end
  end
end
