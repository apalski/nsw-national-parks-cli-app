require "./config/environment"

class CLI

  # Loads all the NSW National Parks, puts out welcome message and starts the app
  def call
    NSWParks.new_park
    puts ""
    puts ""
    puts "Welcome to the Unofficial NSW National Parks App"
    start   
  end

  # Puts out a list of all NSW National Parks
  def park_list
    NSWParks.all.each.with_index(1) {|a,i| puts "#{i}. #{a.name}"}
  end 

  # Puts out information on a selected NSW National Park
  def park_info
    park_no = 0
    puts ""
    puts "Enter the number for the park you are interested in:"
    park_no = gets.strip.to_i
    puts ""
    puts NSWParks.all[park_no - 1].name
    puts ""
    NSWParks.park_overview(park_no)
  end

  # Puts out a list of the NSW Regions that contain National Parks
  def park_area
    puts ""
    NSWParks.nsw_areas
  end

  # Puts out a list of National Parks in a selected NSW Region
  def park_region
    region_no = 0
    input = 0
    areas = park_area
    puts "Enter the number for the region you are interested in:"
    region_no = gets.strip
    puts ""
    puts "The parks in the #{areas[region_no.to_i - 1]} region are:"
    array = NSWParks.park_region(region_no)
    array.each.with_index(1) {|a,i| puts "#{i}. #{a}"}
    puts "Pick your park number from 'list' and use 'info' for more information"
  end

  # Starts the app and gives users the available options for the app
  def start
    answer = 0 
    while answer != "exit"
      puts ""
      puts "For a list of all NSW National Parks enter 'list'"
      puts "To exit the program enter 'exit'"
      puts "To see the National Park regions in NSW enter 'area'"
      puts "To choose a park by its region enter 'region'"
      puts "For more information on a park enter 'info"
      puts ""
      answer = gets.strip
      if answer == "list"
          park_list
      elsif answer == "info"
          park_info  
      elsif answer == "area"
          park_area          
      elsif answer == "region"
          park_region             
      end 
    end  
    puts "Thank you for using the Unofficial NSW National Parks App"   
    puts ""   
  end
end


