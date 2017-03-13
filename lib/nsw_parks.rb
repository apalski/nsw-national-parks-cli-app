require '../config/environment'

class NSWParks

	attr_accessor :name, :park_url, :park_region

	@@all = []

	def initialize (name, park_url)
		@name = name
		@park_url = park_url
		@@all << self
	end

	def self.all
		@@all 
	end

   	def self.new_park
   		page = Nokogiri::HTML(open("http://www.nationalparks.nsw.gov.au/conservation-and-heritage/national-parks"))		
	    park = page.css("#content__inner .dynamicListing li a")
	    park.collect {|a| new(a.text.strip, a.attribute("href").value)}
  	end 	

  	def self.park_overview(park_no)
  		# Select the park from the list in .CLI
  		park = Nokogiri::HTML(open("#{@@all[park_no - 1].park_url}"))
		# Brief description of the park
		parks_overview = park.css("#content__inner div.overviewIntro p[1]").text
  	end

 end 	


















