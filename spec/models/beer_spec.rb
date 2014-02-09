require 'spec_helper'

describe Beer do
	it "is not saved when it is not given a name" do
		beer = Beer.new style:"Lager"
	
		expect(beer).not_to be_valid
		expect(Beer.count).to eq(0)
	end

	it "is not saved when it is not given a style" do
		beer = Beer.new name:"Kalja"

		expect(beer).not_to be_valid
		expect(Beer.count).to eq(0)
	end

	describe "when given a name and style" do
		let(:beer){ Beer.create name:"Kalja", style:"Lager" }

		it "is saved" do
			expect(beer).to be_valid
			expect(Beer.count).to eq(1)
		end

	end
end
