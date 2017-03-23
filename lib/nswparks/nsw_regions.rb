class NSWParks::Nsw_regions

	attr_accessor :region_name, :region_url

	@@all = []  # Collects all NSW National Parks Regions

	# Initialize each Nsw_regions instance with a region_name and region_url attribute, no default
	def initialize(region_name, region_url)
		@region_name = region_name
		@region_url = region_url
		@@all << self
	end

	def self.all
		@@all  # Access all created NSW National Parks Regions instances
	end

	# Create new NSW National Parks Regions from the National Parks website
	def self.create_region
		page = Nokogiri::HTML(open("http://www.nationalparks.nsw.gov.au/visit-a-park/"))
		puts region = page.css("#mainParkNavJump .wrapper ul li a")
	    region.collect {|a| new(a.text.strip, "http://www.nationalparks.nsw.gov.au#{a.attribute("href").value}")}
	end

	# Show the Regions that NSW National Parks are listed within
	def self.nsw_regions
   		array = []
		# Put out the list of Regions numerically
		@@all.collect.with_index(1) do |a,i| 
			puts "#{i}. #{a.region_name}"
			array << a.region_name
		end	
		array
    end
end