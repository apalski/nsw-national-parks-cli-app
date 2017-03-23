class NSWParks::Nsw_regions

	attr_accessor :region_name, :region_url

	@@all = []

	def initialize(region_name, region_url)
		@region_name = region_name
		@region_url = region_url
		@@all << self
	end

	def self.all
		@@all
	end
