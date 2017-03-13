require '../config/environment'
require_relative '../lib/nsw_parks'

class CLI

  def call
    puts "Welcome to the NSW National Parks Information App"
    puts ""
    puts "All NSW National Parks are listed below:"
    puts ""
    park_list
  end

  def park_list
    NSWParks.new_park
    list = NSWParks.all.each.with_index(1) do |a,i| 
      puts "#{i}. #{a.name}"
    end 
  end 


end

#CLI.park_list
