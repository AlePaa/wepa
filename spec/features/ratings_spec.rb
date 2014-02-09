require 'spec_helper'
include OwnTestHelper

describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryGirl.create :user }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    fill_in_single_rating

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

  describe "when successfully made" do
    it "shows up in the ratings page" do
      fill_in_single_rating
      click_button "Create Rating"
      visit ratings_path
      expect(page).to have_content 'Number of ratings 1'
      expect(page).to have_content 'iso 3'
    end

    it "shows up in the users page" do
      fill_in_single_rating
      click_button "Create Rating"
      visit user_path(user)
      expect(page).to have_content 'iso 3 15'  
    end

    it "can be removed from the database" do
      fill_in_single_rating
      click_button "Create Rating"
      visit user_path(user)
      
      expect{
	find_link('delete').click
      }.to change{Rating.count}.by(-1)	
    end
  end 
  def fill_in_single_rating
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')
  end
 
end
