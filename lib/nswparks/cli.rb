
class NSWParks::CLI

  # Loads all the NSW National Parks, puts out welcome message and starts the app
  def call
    NSWParks::Nsw_parks.create_park
    NSWParks::Nsw_regions.create_region
    puts ""
    puts ""
    puts " >------------------------------------------------<"
    puts "{ Welcome to the Unofficial NSW National Parks App }"
    puts " >------------------------------------------------<"
    start   
  end

  # Puts out a numerical list of all NSW National Parks
  def park_list
    NSWParks::Nsw_parks.all.each.with_index(1) {|a,i| puts "#{i}. #{a.park_name}"} # Start array index from 1 not 0
  end 

  # Puts out information on a selected NSW National Park using #park_list
  def park_info
    park_list
    park_no = 0
    puts ""
    puts "Enter the number for the park you are interested in:"
    park_no = gets.strip.to_i
    # Validate user input - input must be an integer and exist in the list
    while !(park_no.is_a? Integer) || park_no < 1 || park_no > NSWParks::Nsw_parks.all.size
      park_list
      park_no = NSWParks::Nsw_parks.valid_input?
    end  
    puts ""
    puts NSWParks::Nsw_parks.all[park_no - 1].park_name  # Gives returned park info a heading of the park name
    puts ""
    puts "----------------------------------------------------------------------------------------"
    NSWParks::Nsw_parks.park_info(park_no)  # Puts out park info using Nsw_parks #park_info
  end

  # Puts out a list of National Parks in a selected NSW Region
  def park_region
    region_no = 0
    park_no = 0
    puts ""
    areas = NSWParks::Nsw_regions.nsw_regions  # Use #park_area to output list of NSW Regions and select a region
    puts ""
    puts "Enter the number for the region you are interested in:"
    region_no = gets.strip.to_i 
    # Validate user input - input must be numerical and exist in the list   
    while !(region_no.is_a? Integer) || region_no < 1 || region_no > areas.size
      puts ""
      NSWParks::Nsw_regions.nsw_regions
      region_no = NSWParks::Nsw_parks.valid_input?
    end
    puts ""
    puts "The parks in the #{areas[region_no.to_i - 1]} region are:"
    array = NSWParks::Nsw_regions.park_region(region_no.to_s)
    array.each.with_index(1) {|region,i| puts "#{i}. #{region}"} # Puts parks in region using Nsw_parks
    puts ""
    puts "Enter your park number from this list for more information:"
    park_no = gets.strip.to_i 
    # Validate user input - input must be numerical and exist in the list  
    while !(park_no.is_a? Integer) || park_no < 1 || park_no > array.size
      array = NSWParks::Nsw_regions.park_region(region_no.to_s)
      array.each.with_index(1) {|region,i| puts "#{i}. #{region}"}
      park_no = NSWParks::Nsw_parks.valid_input?
    end
    puts ""
    puts "Information for #{array[park_no - 1]}:"  # Puts out heading of park name
    puts "----------------------------------------------------------------------------------------"
    # Puts out parks info using Nsw_parks #park_from_region to locate park in @@all
    NSWParks::Nsw_parks.park_from_region(array[park_no - 1])  
  end

  # Starts the app and gives users the available options for the app
  def start
    main_menu_option = nil
    while main_menu_option != "exit"
      puts ""
      puts "For a list of NSW National Parks and information on a park enter 'info'"
      puts "To exit the program enter 'exit'"
      puts "To see the National Park regions in NSW and choose a park by its region enter 'region'"
      puts "To access an interactive map of all National Parks in NSW enter 'map'"
      puts "To download a free pocket guide for NSW National Park Regions enter 'guide'"
      puts "To visit the website for a National Park enter 'url'"
      puts ""
      main_menu_option = gets.strip
      if main_menu_option == "info"
          park_info         
      elsif main_menu_option == "region"
          park_region 
      elsif main_menu_option == "url"
          NSWParks::Nsw_parks.park_url
      elsif main_menu_option == "map"
          NSWParks::Nsw_parks.park_map  
      elsif main_menu_option == "guide"
          NSWParks::Nsw_parks.park_guide  
      # Validates the user input              
      elsif main_menu_option != "exit"
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
