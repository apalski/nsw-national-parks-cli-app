
class NSWParks::CLI

  # Loads all the NSW National Parks, puts out welcome message and starts the app
  def call
    NSWParks::Nsw_parks.new_park
    puts ""
    puts ""
    puts " >------------------------------------------------<"
    puts "{ Welcome to the Unofficial NSW National Parks App }"
    puts " >------------------------------------------------<"
    start   
  end

  # Puts out a numerical list of all NSW National Parks
  def park_list
    NSWParks::Nsw_parks.all.each.with_index(1) {|a,i| puts "#{i}. #{a.name}"} # Start array index from 1 not 0
  end 

  # Puts out information on a selected NSW National Park using #park_list
  def park_info
    park_list
    park_no = 0
    puts ""
    puts "Enter the number for the park you are interested in:"
    park_no = gets.strip.to_i
    # Validate user input - input must be an integer and exist in the list
    while !(park_no.is_a? Integer) || park_no < 1 || park_no > NSWParks::Nsw_parks.all.length
      park_list
      park_no = NSWParks::Nsw_parks.valid_input
    end  
    puts ""
    puts NSWParks::Nsw_parks.all[park_no - 1].name  # Gives returned park info a heading of the park name
    puts ""
    puts "----------------------------------------------------------------------------------------"
    NSWParks::Nsw_parks.park_overview(park_no)  # Puts out park info using Nsw_parks #park_overview
  end

  # Puts out a list of the NSW Regions that contain National Parks using Nsw_parks #nsw_areas
  def park_area
    puts ""
    NSWParks::Nsw_parks.nsw_areas
  end

  # Puts out a list of National Parks in a selected NSW Region
  def park_region
    region_no = 0
    input = 0
    areas = park_area  # Use #park_area to output list of NSW Regions
    puts "Enter the number for the region you are interested in:"
    region_no = gets.strip.to_i 
    # Validate user input - input must be numerical and exist in the list   
    while !(region_no.is_a? Integer) || region_no < 1 || region_no > areas.length
      park_area
      region_no = NSWParks::Nsw_parks.valid_input
    end
    puts ""
    puts "The parks in the #{areas[region_no.to_i - 1]} region are:"
    array = NSWParks::Nsw_parks.park_region(region_no.to_s)
    array.each.with_index(1) {|a,i| puts "#{i}. #{a}"} # Puts parks in region using Nsw_parks
    puts ""
    puts "Enter your park number from this list for more information:"
    input = gets.strip.to_i 
    # Validate user input - input must be numerical and exist in the list  
    while !(input.is_a? Integer) || input < 1 || input > array.length
      array = NSWParks::Nsw_parks.park_region(region_no.to_s)
      array.each.with_index(1) {|a,i| puts "#{i}. #{a}"}
      input = NSWParks::Nsw_parks.valid_input
    end
    puts ""
    puts "Information for #{array[input - 1]}:"  # Puts out heading of park name
    puts "----------------------------------------------------------------------------------------"
    # Puts out parks info using Nsw_parks #park_from_region to locate park in @@all
    NSWParks::Nsw_parks.park_from_region(array[input - 1])  
  end

  # Accesses the website information for a selected NSW National Park using Nsw_parks #park_url
  def park_url
    puts ""
    NSWParks::Nsw_parks.park_url
  end

  # Accesses the website information for an interactive map of all parks using Nsw_parks #park_map
  def park_map
    puts ""
    NSWParks::Nsw_parks.park_map
  end

  # Accesses the website information for free park guide downloads using Nsw_parks #park_guide
  def park_guide
    puts ""
    NSWParks::Nsw_parks.park_guide
  end

  # Starts the app and gives users the available options for the app
  def start
    answer = 0 
    while answer != "exit"
      puts ""
      puts "For a list of NSW National Parks and information on a park enter 'info'"
      puts "To exit the program enter 'exit'"
      puts "To see the National Park regions in NSW and choose a park by its region enter 'region'"
      puts "To access an interactive map of all National Parks in NSW enter 'map'"
      puts "To download a free pocket guide for NSW National Park Regions enter 'guide'"
      puts "To visit the website for a National Park enter 'url'"
      puts ""
      answer = gets.strip
      if answer == "info"
          park_info         
      elsif answer == "region"
          park_region 
      elsif answer == "url"
          park_url
      elsif answer == "map"
          park_map  
      elsif answer == "guide"
          park_guide   
      # Validates the user input              
      elsif answer != "exit"
          puts ""
          puts "---------------------------------------------"
          puts "Please enter one of the options from the list"  # Prompt user to enter again 
          puts "---------------------------------------------"                                   
      end 
    end  
    puts ""
    puts "---------------------------------------------------------"
    puts "Thank you for using the Unofficial NSW National Parks App"  
    puts "---------------------------------------------------------" 
    puts ""   
  end
end
