require 'rails_helper'

RSpec.describe "dashboard authentication" do
  before do
    test_data
  end

  it "won't allow visitor to access dashboard without login" do
    visit root_path
    click_on "Dashboard"

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Must be logged in to view dashboard")
  end
end