require 'rails_helper'

feature "AddNewClients", :type => :feature do
  it "should require the user log in before adding a client" do
    login_as create( :user ), scope: :user

    visit new_client_path
    # puts page.body

    within "#new_client" do
      fill_in "client_name", with: "Client title"
    end

    click_link_or_button "Create Client"

    expect( Client.count ).to eq(1)
    expect( Client.first.name).to eq( "Client title")
  end
end