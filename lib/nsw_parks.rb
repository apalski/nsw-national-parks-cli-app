require '../config/environment'

class NSWParks

	attr_accessor :name, :park_url, :park_region

	@@all = []  # Collect all NSW National Parks 

	def initialize (name, park_url)
		@name = name
		@park_url = park_url
		@@all << self  # Add each new NSW National Park as it is created
	end

	def self.all
		@@all  # Access all created NSW National Parks
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

  	# If the user wants to know more about the National Park e.g. camping sites
    def self.park_highlights(park_no)
   	  parks = Nokogiri::HTML(open("#{@park_url[park_no]}"))
      # Parks highlights such as camping grounds
   	  parks_highlights = parks.css("#content__inner ul.dynamicListing li")
   	  parks_management = parks.css("#content__inner div.overviewIntro a")
      # Link to further info website
   	  park_link = parks_management.attribute("href").value.to_s
      # If the selected National Park does not have any highlights listed give info website
   	  if parks_highlights.empty?
   	  	text = "For detailed park and fire management documents, visit the OEH website at #{park_link}"
   	  	text.gsub(URI.regexp, '<a href="\0">\0</a>')
   	  else
        # Highlights heading for the highlights section
   	  	parks.css("#content__inner .detailLeftColumn h2").text
      	parks_highlights.each {|a| a.text}
   	  end
   end

   def self.nsw_regions
		regions = Nokogiri::HTML(open("http://www.nationalparks.nsw.gov.au/visit-a-park"))
		list = regions.css("#mainParkNavJump ul li")
		list.collect.with_index(1) {|a,i| puts "#{i}. #{a.children.text}"}
   end

   def self.park_region
  		@@all.each.with_index do |region, i|
  			park = Nokogiri::HTML(open("#{@@all[i].park_url}"))
  		 	@@all[i].park_region = park.css("#content__inner ul.parkDetail li.parkDetail__region").text
  		end	
   end
	
 end 	

















