require '../config/environment'
#require_relative '../lib/nsw_parks'

class CLI

  def call
    
    puts "Welcome to the NSW National Parks Information App"
    puts ""
    puts "For a list of all NSW National Parks enter 'list'"
    puts "To exit the program enter 'exit'"
    puts "To choose a park by its region enter 'region'"
    puts "For more information on a park enter 'info"
    puts ""
    start   
  end

  def park_list
    NSWParks.new_park
    NSWParks.all.each.with_index(1) {|a,i| puts "#{i}. #{a.name}"}
  end 

  def park_info
    park_no = 0
    puts "Enter the number for the park you are interested in:"
    park_no = gets.strip.to_i
    NSWParks.park_overview(park_no)
    NSWParks.park_highlights(park_no)
  end

  def start
    answer = 0
    answer = gets.strip
    while answer != "exit"
      case answer
        when "list"
          park_list
        when "region"
          park_region  
        when "info"
          park_info
      end    
    end    
  end


end



