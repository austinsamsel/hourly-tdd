require 'rails_helper'

feature "AddNewClients", :type => :feature do
  it "should create a new client with a logged in user" do
    login_as create( :user ), scope: :user

    visit new_client_path
    # puts page.body

    within "#new_client" do
      fill_in "client_name", with: "Client name"
    end

    click_link_or_button "Create Client"

    expect( Client.count ).to eq(1)
    expect( Client.first.name).to eq( "Client name")

  end

end