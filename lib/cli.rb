require "./config/environment"

class CLI

  # Loads all the NSW National Parks, puts out welcome message and starts the app
  def call
    NSWParks.new_park
    puts ""
    puts ""
    puts " >------------------------------------------------<"
    puts "{ Welcome to the Unofficial NSW National Parks App }"
    puts " >------------------------------------------------<"
    start   
  end

  # Puts out a list of all NSW National Parks
  def park_list
    NSWParks.all.each.with_index(1) {|a,i| puts "#{i}. #{a.name}"}
  end 

  # Puts out information on a selected NSW National Park
  def park_info
    park_list
    park_no = 0
    puts ""
    puts "Enter the number for the park you are interested in:"
    park_no = gets.strip.to_i
    puts ""
    puts NSWParks.all[park_no - 1].name
    puts ""
    puts "----------------------------------------------------------------------------------------"
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
    puts ""
    puts "Enter your park number from this list for more information:"
    input = gets.strip.to_i
    if !integer?(input)
      array = NSWParks.park_region(region_no)
      array.each.with_index(1) {|a,i| puts "#{i}. #{a}"}
      puts "Please enter one of the park numbers in the list"
      input = gets.strip.to_i
    elsif input < 0 || input > NSWParks.all.length
      puts "Please enter one of the park numbers in the list" 
      input = gets.strip.to_i
    else  
      puts ""
      puts "Information for #{array[input - 1]}:"
      puts "----------------------------------------------------------------------------------------"
      NSWParks.park_from_region(array[input - 1])
    end  
  end

  # Accesses the website information for a selected NSW National Park
  def park_url
    puts ""
    NSWParks.park_url
  end

  # Starts the app and gives users the available options for the app
  def start
    answer = 0 
    while answer != "exit"
      puts ""
      puts "For a list of all NSW National Parks enter 'list'"
      puts "To exit the program enter 'exit'"
      puts "To see the National Park regions in NSW and choose a park by its region enter 'region'"
      puts "For more information on a park enter 'info"
      puts "To visit the website for a National Park enter 'url'"
      puts ""
      answer = gets.strip
      if answer == "list"
          park_list
      elsif answer == "info"
          park_info         
      elsif answer == "region"
          park_region 
      elsif answer == "url"
          park_url  
      else
          puts ""
          puts "---------------------------------------------"
          puts "Please enter one of the options from the list"   
          puts "---------------------------------------------"                                   
      end 
    end  
    puts ""
    puts "Thank you for using the Unofficial NSW National Parks App"   
    puts ""   
  end
end


