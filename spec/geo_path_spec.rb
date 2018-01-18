require "spec_helper"
#require '../lib/espresso_path/geo_path'
require 'espresso_path'
require 'espresso_path/geo_path'
include EspressoPath
RSpec.describe EspressoPath::GeoPath do




  it "login and set token" do
    #EspressoPath::GeoPath.login
    #GeoPath.login
    #geo_path = EspressoPath::GeoPath.new
    geo_path2 = GeoPath.new
  end


  it "login and get audiences" do

    geo_path = GeoPath.new
    geo_path.login
    puts geo_path.day_parts
  end
end
