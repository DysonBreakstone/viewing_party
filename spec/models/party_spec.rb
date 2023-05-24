require 'rails_helper'

RSpec.describe Party do
  describe "relationships", :vcr do
    it { should have_many(:user_parties) }
    it { should have_many(:users).through(:user_parties) }
  end

  describe "validations", :vcr do
    it { should validate_numericality_of :duration }
    it { should validate_presence_of :date }
    it { should validate_presence_of :time }
  end
  describe "instance methods" do
    before(:each) do
      test_data
      @party_1 = Party.create!(duration: 200, date: "Tue, 9 May 2023", time: "12:00", movie_id: 238)
      @party_2 = Party.create!(duration: 180, date: "Mon, 16 Jan 2023", time: "18:00", movie_id: 550)

      @party_1.user_parties.create!(user_id: @user_2.id)
      @party_1.user_parties.create!(user_id: @user_3.id)
      @party_1.user_parties.create!(user_id: @user_4.id, is_host: true)
      @party_2.user_parties.create!(user_id: @user_3.id, is_host: true)
      @party_2.user_parties.create!(user_id: @user_4.id)
      @party_2.user_parties.create!(user_id: @user_5.id)
    end
    describe "guests" do
      it "returns list of users who are not hosting party", :vcr do
        expect(@party_1.guests.sort).to eq([@user_2, @user_3].sort)
        expect(@party_2.guests.sort).to eq([@user_4, @user_5].sort)
      end
    end
    describe "format_date" do
      it "returns a formatted date of the party", :vcr do
        expect(@party_1.format_date).to eq("May 09, 2023")
        expect(@party_2.format_date).to eq("January 16, 2023")
      end
    end
    describe "format_time" do
      it "returns a formatted time of the party", :vcr do
        expect(@party_1.format_time).to eq("12:00 pm")
        expect(@party_2.format_time).to eq("6:00 pm")
      end
    end
    describe "host" do
      it "returns the name of the host", :vcr do
        expect(@party_1.host).to eq(@user_4.name)
        expect(@party_2.host).to eq(@user_3.name)
      end
    end
  end
end
