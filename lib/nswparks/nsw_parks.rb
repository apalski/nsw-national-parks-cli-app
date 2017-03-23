
class NSWParks::Nsw_parks

	attr_accessor :name, :park_url

	@@all = []  # Collects all NSW National Parks 

	# Initialize each Nsw_parks instance with a name and park_url attribute, no default
	def initialize (name, park_url)
		@name = name
		@park_url = park_url
		@@all << self  # Add each new NSW National Park instance to the collection as it is created
	end

	def self.all
		@@all  # Access all created NSW National Parks instances
	end

	# Create new NSW National Parks from the National Parks website
   	def self.new_park
   		page = Nokogiri::HTML(open("http://www.nationalparks.nsw.gov.au/conservation-and-heritage/national-parks"))		
	    park = page.css("#content__inner .dynamicListing li a")
	    park.collect {|a| new(a.text.strip, a.attribute("href").value)}
  	end 	

  	# Allow users to access information on any NSW National Park
  	def self.park_overview(park_no)
  		check = ""
  		# Select the park from the list in @@all using the park's park_url attribute
  		park = Nokogiri::HTML(open("#{@@all[park_no - 1].park_url}"))
		# Description of the park and its attractions
		check = park.css("#content__inner div.overviewIntro div.overviewIntro__readMoreText p")
		# If there is no overview available display alternative text for the park
		if check.empty?
			puts park.css("#content__inner div.overviewIntro p").text
			link = park.css("#content__inner div.overviewIntro a")
			puts "The OEH website can be found at #{link.attribute("href").value}"
			url_use  # Instructions to the user on how to use the provided website links
		else  # If overview available put that out to the user
			puts park.css("#content__inner div.overviewIntro div.overviewIntro__readMoreText p").text
		end	
		puts "----------------------------------------------------------------------------------------"
  	end

  	# Validates the user input for all numerical user inputs
	def self.valid_input
      puts ""
      puts "---------------------------------------------------------"
      puts "Please enter one of the numbers from the list above:"  # Prompt user to enter again
      puts "---------------------------------------------------------"
      gets.strip.to_i
    end			

    # Accesses the website information for a selected NSW National Park
    def self.park_url
   		input = 0
   		@@all.each.with_index(1) {|a,i| puts "#{i}. #{a.name}"} # Puts outs list of National Parks
   		puts ""
   		puts "Select the park number from above and enter the number to access the website address"
   		input = gets.strip.to_i
   		# Validate user input - input must be numerical and exist in the list
   		while !(input.is_a? Integer) || input < 1 || input > @@all.length  
   			@@all.each.with_index(1) {|a,i| puts "#{i}. #{a.name}"}  # Puts outs list of National Parks
   			input = valid_input
   		end	
   		system("open #{@@all[input - 1].park_url}")  # Puts out the park website address
    end

    # Provides user with a link to the map and instructions to open the link in their browser
    def self.park_map
   		system("open http://www.nationalparks.nsw.gov.au/nsw-state-map") # Cannot scrape - hidden content
    end

    # Provides user with a link to guides and instructions to open the link in their browser
    def self.park_guide
   		page = Nokogiri::HTML(open("http://www.nationalparks.nsw.gov.au"))	
   		link = page.css("#headerNavBottom nav ul li#mainNav__about .box ul li[5] a")
   		system("open #{link.attribute("href").value}")  # Puts out the website address for the park guides
   	end	
 end 	

