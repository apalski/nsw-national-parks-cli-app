require '../config/environment'
#require_relative '../lib/nsw_parks'

class CLI

  def call
    
    puts "Welcome to the NSW National Parks Information App"
    puts ""
    puts "For a list of all NSW National Parks enter 'list'"
    puts "To exit the program enter 'exit'"
    puts "For more information on a park enter 'info"
    puts ""
    start   
  end

  def park_list
    NSWParks.new_park
    NSWParks.all.each.with_index(1) {|a,i| puts "#{i}. #{a.name}"}
  end 

  def start
    answer = 0
    answer = gets.strip
    while answer != "exit"
      if answer == "list"
        park_list
      end  
  end


end



