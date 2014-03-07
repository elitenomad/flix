require 'spec_helper'

describe "Deleting a user" do
  it "destroys the user and redirects to the home page" do
    user = User.create!(user_attributes({name:'shanti',username:'shanti'}))
    count_before = User.count

    visit user_path(user)

    click_link 'Delete Account'

    count_after = User.count
    expect(count_after).to be < count_before
    expect(current_path).to eq(root_path)
    expect(page).to have_text('Account successfully deleted!')

    visit users_path

    expect(page).not_to have_text(user.name)
  end
end