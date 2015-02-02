require 'rails_helper'

RSpec.describe "works/show", :type => :view do
  before(:each) do
    @work = assign(:work, Work.create!(
      :title => "Title",
      :description => "MyText",
      :billed => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/false/)
  end
end
