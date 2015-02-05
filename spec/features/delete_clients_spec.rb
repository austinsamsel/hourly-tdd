require 'rails_helper'

feature "DeleteClients", :type => :feature do
    it "should delete a client with a logged in user" do
    login_as create( :user ), scope: :user

    visit new_client_path
    # puts page.body

    within "#new_client" do
      fill_in "client_name", with: "Client name"
    end

    click_link_or_button "Create Post"

    expect( Post.count ).to eq(1)
    expect( Post.first.name).to eq( "Post title")

    visit index_client_path

    click_link_or_button "Destroy"

  end

end
