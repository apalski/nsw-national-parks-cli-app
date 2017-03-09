require '../config/environment'

class NSWParks

	attr_accessor :name, :town, :phone_number, :park_url

	@@all = []

	def initialize(name = nil, park_url = nil)
		@name = name
		@park_url = park_url
		@@all << self
	end

	def self.get_page
  	   Nokogiri::HTML(open("http://www.nationalparks.nsw.gov.au/conservation-and-heritage/national-parks"))
    end

   	def self.new_park
	    park = self.get_page.css("#content ul.dynamicListing li a")
	    park.each {|a| NSWParks.new(a.children.text, a.attribute("href").value)}
  	end 

	def self.all
		@@all	
	end
end


