require 'spec_helper'

describe "Viewing the list of users" do

  it "shows the single user" do
    user1 = User.create!(user_attributes(username: "Larry1", email: "larry1@example.com"))

    visit users_url

    expect(page).to have_link(user1.name)

  end

  it "shows multiple users" do
    user1 = User.create!(user_attributes(username: "Larry1", email: "larry1@example.com"))
    user2 = User.create!(user_attributes(username: "Larry2", email: "larry2@example.com"))
    users = User.all

    visit users_url

    expect(users.count).should be > 0
    users.each do |user|
      expect(page).to have_link(user.name)
    end
  end

end