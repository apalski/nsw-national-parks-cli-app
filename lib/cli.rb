#require '../config/environment'
#require_relative '../lib/nsw_parks'

class CLI

  def call
    NSWParks.new_park
    puts ""
    puts ""
    puts "Welcome to the NSW National Parks Information App"
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

  def start
    answer = 0 
    while answer != "exit"
      puts ""
      puts "For a list of all NSW National Parks enter 'list'"
      puts "To exit the program enter 'exit'"
      puts "To choose a park by its region enter 'region'"
      puts "For more information on a park enter 'info"
      puts ""
      answer = gets.strip
      if answer == "list"
          park_list
      elsif answer == "region"
          park_region  
      elsif answer == "info"
          park_info             
      end 
    end  
    puts "Please run the program again for more options"      
  end
end



