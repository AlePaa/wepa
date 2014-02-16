require 'spec_helper'
require 'beermapping_answers_helper'
describe "BeermappingApi" do
  it "When HTTP GET returns one entry, it is parsed and returned" do

    stub_request(:get, /.*tampere/).to_return(body: canned_answer, headers: { 'Content-Type' => "text/xml" })

    places = BeermappingApi.places_in("tampere")

    expect(places.size).to eq(1)
    place = places.first
    expect(place.name).to eq("O'Connell's Irish Bar")
    expect(place.street).to eq("Rautatienkatu 24")
  end
  
  it "When HTTP GET returns zero entries, returns an empty table" do

    stub_request(:get, /.*mesta/).to_return(body: empty_answer, headers: { 'Content-Type' => "text/xml" })

    places = BeermappingApi.places_in("mesta")
    expect(places).to be_empty
  end

  it "When HTTP GET returns multiple entries, returns all of them" do

    stub_request(:get, /.*helsinki/).to_return(body: multi_answer, headers: { 'Content-Type' => "text/xml" })

    places = BeermappingApi.places_in("helsinki")
    expect(places.size).to eq(7)
  end
end
