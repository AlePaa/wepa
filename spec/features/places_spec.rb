require 'spec_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    BeermappingApi.stub(:places_in).with("kumpula").and_return(
        [ Place.new(:name => "Oljenkorsi") ]
    )

    visit_kumpula

    expect(page).to have_content "Oljenkorsi"
  end

  it "if several are returned by the API, they are shown at the page" do
    BeermappingApi.stub(:places_in).with("kumpula").and_return(
       [ Place.new(:name => "Oljenkorsi"), Place.new(:name => "Gurula") ]
   )

  visit_kumpula

  expect(page).to have_content "Gurula"
  expect(page).to have_content "Oljenkorsi"
  end

  it "if none are returned by the API, the list is empty" do
    BeermappingApi.stub(:places_in).with("kumpula").and_return([])

    visit_kumpula
    expect(page).to have_content "No locations in kumpula"
  end

  def visit_kumpula
    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"
  end
end
