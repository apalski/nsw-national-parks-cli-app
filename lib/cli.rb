#require '../config/environment'
#require_relative '../lib/nsw_parks'
require 'background_lite'

class CLI

  def call
    NSWParks.new_park
    puts ""
    puts ""
    puts "Welcome to the Unofficial NSW National Parks App"
    start   
  end

  def park_list
    NSWParks.all.each.with_index(1) {|a,i| puts "#{i}. #{a.name}"}
  end 

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

  def park_area
    puts ""
    NSWParks.nsw_areas
  end

  def park_region
    region_no = 0
    park_area
    puts "Enter the number for the region you are interested in:"
    region_no = gets.strip
    array = NSWParks.park_region(region_no)
    array.each.with_index {|a,i| puts "#{i}. #{a}"}
  end

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



