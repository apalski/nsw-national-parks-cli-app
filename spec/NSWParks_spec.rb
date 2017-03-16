
describe NSWParks do
  it "has a version number" do
    expect(NSWParks::VERSION).not_to be nil
  end
end  

describe 'NSWPark' do
  describe '#initialize' do
    it 'sets the name of the park in @name and sets the url in @park_url and adds the park instance to @@all' do
      park = NSWParks::Nsw_parks.new("Ben Boyd National Park", "http://www.nationalparks.nsw.gov.au/visit-a-park/parks/ben-boyd-national-park")

      expect(park.instance_variable_get(:@name)).to eq("Ben Boyd National Park")
      expect(park.instance_variable_get(:@park_url)).to eq("http://www.nationalparks.nsw.gov.au/visit-a-park/parks/ben-boyd-national-park")
      expect(NSWParks::Nsw_parks.all).to include(park)
    end
  end
end

describe "#new_park" do
	it "uses Nokogiri to get the HTML from a web page" do 
	  page = Nokogiri::HTML(open("http://www.nationalparks.nsw.gov.au/conservation-and-heritage/national-parks"))	
	  expect{NSWParks::Nsw_parks.new_park}.to_not raise_error
	  expect(page).to be_a(Nokogiri::HTML::Document) 
	end
 end

 		
