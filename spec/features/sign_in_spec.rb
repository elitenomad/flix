require 'rspec'

describe 'My behaviour' do
  it "redirects to the intended page" do
    user = User.create!(user_attributes)

    visit users_url

    expect(current_path).to eq(signin_path)

    sign_in(user)

    expect(current_path).to eq(users_path)
  end
end