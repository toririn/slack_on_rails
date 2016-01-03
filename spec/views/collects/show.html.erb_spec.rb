require 'rails_helper'

RSpec.describe "collects/show", type: :view do
  before(:each) do
    @collect = assign(:collect, Collect.create!(
      :name => "Name",
      :text => "Text"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Text/)
  end
end
