# require 'rails_helper'

# RSpec.describe "works/edit", :type => :view do
#   before(:each) do
#     @work = assign(:work, Work.create!(
#       :title => "MyString",
#       :description => "MyText",
#       :billed => false
#     ))
#   end

#   it "renders the edit work form" do
#     render

#     assert_select "form[action=?][method=?]", work_path(@work), "post" do

#       assert_select "input#work_title[name=?]", "work[title]"

#       assert_select "textarea#work_description[name=?]", "work[description]"

#       assert_select "input#work_billed[name=?]", "work[billed]"
#     end
#   end
# end
