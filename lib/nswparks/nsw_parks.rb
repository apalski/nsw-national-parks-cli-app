
class NSWParks::Nsw_parks

	attr_reader :park_name, :park_url

	@@all = []  # Collects all NSW National Parks 

	# Initialize each Nsw_parks instance with a name and park_url attribute, no default
	def initialize (park_name, park_url)
		@park_name = park_name
		@park_url = park_url
		@@all << self  # Add each new NSW National Park instance to the collection as it is created
	end

	def self.all
		@@all  # Access all created NSW National Parks instances
	end

	# Create new NSW National Parks instances from the National Parks website
   	def self.create_park
   		page = Nokogiri::HTML(open("http://www.nationalparks.nsw.gov.au/conservation-and-heritage/national-parks"))		
	    park = page.css("#content__inner .dynamicListing li a")
	    park.collect {|a| new(a.text.strip, a.attribute("href").value)}
  	end 	

  	# Allow users to access information on any NSW National Park
  	def self.park_info(park_no)
  		check_for_overview = nil
  		# Select the park from the list in @@all using the park's park_url attribute
  		park = Nokogiri::HTML(open("#{@@all[park_no - 1].park_url}"))
  		# Description of the park and its attractions
  		check_for_overview = park.css("#content__inner div.overviewIntro div.overviewIntro__readMoreText p")
  		# If there is no overview available display alternative text for the park
  		if check_for_overview.empty?
  			puts park.css("#content__inner div.overviewIntro p").text
  			link = park.css("#content__inner div.overviewIntro a")
  			puts "The OEH website can be found at #{link.attribute("href").value}"
  		else  # If overview available put that out to the user
  			puts park.css("#content__inner div.overviewIntro div.overviewIntro__readMoreText p").text
  		end	
  		puts "----------------------------------------------------------------------------------------"
  	end

  	# Handles output to user for input validations for all numerical user inputs
	def self.valid_input?
      puts ""
      puts "---------------------------------------------------------"
      puts "Please enter one of the numbers from the list above:"  # Prompt user to enter again
      puts "---------------------------------------------------------"
      gets.strip.to_i  # receive and return user input
    end			

    # Accesses the website information for a selected NSW National Park
    # Opens the park website in the user's default browser
    def self.park_url
   		park_no = 0
   		@@all.each.with_index(1) {|a,i| puts "#{i}. #{a.park_name}"} # Puts outs list of National Parks
   		puts ""
   		puts "Select the park number from above and enter the number to access the website address"
   		park_no = gets.strip.to_i
   		# Validate user input - input must be numerical and exist in the list
   		while !(park_no.is_a? Integer) || park_no < 1 || park_no > @@all.length  
   			@@all.each.with_index(1) {|a,i| puts "#{i}. #{a.park_name}"}  # Puts outs list of National Parks
   			park_no = valid_input?
   		end	
   		system("open #{@@all[park_no - 1].park_url}")  # Puts out the park website address
    end

    # Return overview for a park using its listing under its region
    def self.park_from_region(park)
 		@@all.each.with_index do |a,i| 
 			# Find the park in region in the @@all array and return its overview
 			if a.park_name == park
 				park_info(i + 1) 
 			end
		end	
	end	

    # Opens the interactive NSW Map in the user's default browser
    def self.park_map
   		system("open http://www.nationalparks.nsw.gov.au/nsw-state-map") # Cannot scrape - hidden content
    end

    # Opens the download page for pocket guides in the user's default browser
    def self.park_guide
   		page = Nokogiri::HTML(open("http://www.nationalparks.nsw.gov.au"))	
   		link = page.css("#headerNavBottom nav ul li#mainNav__about .box ul li[5] a")
   		system("open #{link.attribute("href").value}")  # Puts out the website address for the park guides
   	end	
 end 	

