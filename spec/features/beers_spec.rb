require 'spec_helper'

include OwnTestHelper

describe "Beer" do
    let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }

    before :each do
    FactoryGirl.create :user
    end

    it "is saved when name field has a valid value" do
      sign_in_as_pekka      	
      visit new_beer_path 
      fill_in('beer_name', with:"Kalija")
      select('Koff', from:'beer[brewery_id]')
    
      expect{
        click_button('Create Beer')
      }.to change{Beer.count}.by(1)
    end

  describe "with invalid beer name" do
    it "return to create a beer page" do
      sign_in_as_pekka
      visit new_beer_path
      fill_in('beer_name', with:"")
      select('Koff', from:'beer[brewery_id]')
      click_button('Create Beer')
     
      expect(page).to have_content "Name can't be blank"
    end
  end
  def sign_in_as_pekka
    visit signin_path
    sign_in(username:"Pekka", password:"Foobar1")
  end
end
