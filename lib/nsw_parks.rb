require 'nokogiri'
require 'open-uri'

class NSWParks

	attr_accessor :name, :park_url, :park_region

	@@all = []  # Collect all NSW National Parks 
	@@areas = []

	def initialize (name, park_url)
		@name = name
		@park_url = park_url
		@@all << self  # Add each new NSW National Park to the collection as it is created
	end

	def self.all
		@@all  # Access all created NSW National Parks
	end

	# Create new NSW National Parks from the National Parks webstie
   	def self.new_park
   		page = Nokogiri::HTML(open("http://www.nationalparks.nsw.gov.au/conservation-and-heritage/national-parks"))		
	    park = page.css("#content__inner .dynamicListing li a")
	    park.collect {|a| new(a.text.strip, a.attribute("href").value)}
  	end 	

  	# Allow user to access an overview of a NSW National Park
  	def self.park_overview(park_no)
  		# Select the park from the list in .CLI
  		park = Nokogiri::HTML(open("#{@@all[park_no - 1].park_url}"))
		# Description of the park
		puts parks_overview = park.css("#content__inner div.overviewIntro div.overviewIntro__readMoreText p").text
  	end
  	
   # Show the Regions that NSW National Parks are listed within
   def self.nsw_areas
   		array = []
		regions = Nokogiri::HTML(open("http://www.nationalparks.nsw.gov.au/visit-a-park"))
		list = regions.css("#mainParkNavJump ul li")
		# Put out the list of Regions numerically
		list.collect.with_index(1) do |a,i| 
			puts "#{i}. #{a.children.text}"
			array << a.children.text
		end	
		array
   end

   # Assign a region to each NSW National Park in the collection
   def self.park_region(region_no)
   		array = []
   		case region_no
   		when "1"
			region = Nokogiri::HTML(open("http://www.nationalparks.nsw.gov.au/visit-a-park/regions/outback"))
		 	links = region.css("#content__inner ul.detailRightColumn__linkList a")
			array = region_sort(links)
			array
		when "2"
			region = Nokogiri::HTML(open("http://www.nationalparks.nsw.gov.au/visit-a-park/regions/country-nsw"))	
			links = region.css("#content__inner ul.detailRightColumn__linkList a")
		 	array = region_sort(links)
			array			
		end				
   end

   def self.region_sort(links)
   		array = []
   		links.collect {|a| array << a.text}
		array.select! {|a| a.include?("National")}
		array		
   end
	
 end 	



NSWParks.nsw_areas













