require "./config/environment"

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

  	# Allow user to access an information on a NSW National Park
  	def self.park_overview(park_no)
  		check = ""
  		# Select the park from the list in .CLI
  		park = Nokogiri::HTML(open("#{@@all[park_no - 1].park_url}"))
		# Description of the park
		check = park.css("#content__inner div.overviewIntro div.overviewIntro__readMoreText p")
		# If there is no overview available display alternative text
		if check.empty?
			puts park.css("#content__inner div.overviewIntro p").text
		else	
			puts park.css("#content__inner div.overviewIntro div.overviewIntro__readMoreText p").text
		end	
		puts "----------------------------------------------------------------------------------------"
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

   # Output the National Parks for each of the seven NSW Regions
   def self.park_region(region_no)
   		array = []
   		case region_no
   		when "1"
			region = Nokogiri::HTML(open("http://www.nationalparks.nsw.gov.au/visit-a-park/regions/outback"))
		 	links = region.css("#content__inner ul.detailRightColumn__linkList a")
		 	array = region_sort(links) # Remove areas that are not National Parks 
			array	
		when "2"
			region = Nokogiri::HTML(open("http://www.nationalparks.nsw.gov.au/visit-a-park/regions/country-nsw"))	
			links = region.css("#content__inner ul.detailRightColumn__linkList a")
		 	array = region_sort(links) # Remove areas that are not National Parks 
			array	
		when "3"
			region = Nokogiri::HTML(open("http://www.nationalparks.nsw.gov.au/visit-a-park/regions/murray-riverina"))	
			links = region.css("#content__inner ul.detailRightColumn__linkList a")
		 	array = region_sort(links)  # Remove areas that are not National Parks 
			array	
		when "4"
			region = Nokogiri::HTML(open("http://www.nationalparks.nsw.gov.au/visit-a-park/regions/north-coast"))	
			links = region.css("#content__inner ul.detailRightColumn__linkList a")
		 	array = region_sort(links)  # Remove areas that are not National Parks 
			array	
		when "5"
			region = Nokogiri::HTML(open("http://www.nationalparks.nsw.gov.au/visit-a-park/regions/south-coast"))	
			links = region.css("#content__inner ul.detailRightColumn__linkList a")
		 	array = region_sort(links)  # Remove areas that are not National Parks 
			array
		when "6"
			region = Nokogiri::HTML(open("http://www.nationalparks.nsw.gov.au/visit-a-park/regions/sydney-and-surrounds"))	
			links = region.css("#content__inner ul.detailRightColumn__linkList a")
		 	array = region_sort(links)  # Remove areas that are not National Parks 
			array	
		when "7"
			region = Nokogiri::HTML(open("http://www.nationalparks.nsw.gov.au/visit-a-park/regions/snowy-mountains"))	
			links = region.css("#content__inner ul.detailRightColumn__linkList a")
		 	array = region_sort(links)  # Remove areas that are not National Parks 
			array						
		end				
   end

   # Removes areas that are not National Parks from the returned array
   def self.region_sort(links)
   		array = []
   		clean = []
   		links.collect {|a| array << a.children.text}
		array.select! {|a| a.include?("National")}
		clean = array.collect {|a| a.strip}
		clean
   end

   def self.park_from_region(park)
 		@@all.each.with_index do |a,i| 
 			if a.name == park
 				park_overview(i + 1)
 			end
		end	
	end				

   # Accesses the website information for a selected NSW National Park
   def self.park_url
   		input = 0
   		@@all.each.with_index(1) {|a,i| puts "#{i}. #{a.name}"}
   		puts ""
   		puts "Select the park number from above and enter the number to access the website address"
   		input = gets.strip.to_i
   		puts ""
   		puts "The website address for #{@@all[input - 1].name} is:"
   		puts ""
   		puts @@all[input - 1].park_url
   		puts ""
   		puts "<------------------------------------------------------------------------------->"
   		puts "Right-click on the website address and select 'open url' from the dropdown menu!!"
   		puts "            This will open the website in your default browser                   "
   		puts "<------------------------------------------------------------------------------->"
   end
 end 	

















