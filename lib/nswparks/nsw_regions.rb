class NSWParks::Nsw_regions

	attr_reader :region_name, :region_url

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
		region = page.css("#mainParkNavJump .wrapper ul li a")
	    region.collect {|region| new(region.text.strip, "http://www.nationalparks.nsw.gov.au#{region.attribute("href").value}")}
	end

	# Show the Regions that NSW National Parks are listed within
	# Puts out a numerical list of the NSW Regions that contain National Parks 
	def self.nsw_regions
		array = @@all.collect.with_index(1) { |region,i| puts "#{i}. #{region.region_name}"}
    end

    # Output the National Parks for each region as requested
	def self.park_region(region_no)
		region = @@all[region_no.to_i - 1]  # Select the region from the @@all array
		page = Nokogiri::HTML(open("#{region.region_url}"))
		park = page.css("#content__inner ul.detailRightColumn__linkList a")
		array = region_sort(park) # Remove areas that are not National Parks 
	end

	# Removes areas that are not National Parks from the returned array
   def self.region_sort(park)
   		array = park.collect {|parks| parks.children.text}
		array.select! {|parks| parks.include?("National")}
		# Remove leading and trailing white space from the park names
		clean = array.collect {|parks| parks.strip}
   end
end

