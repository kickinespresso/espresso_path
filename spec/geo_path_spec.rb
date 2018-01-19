require "spec_helper"
#require '../lib/espresso_path/geo_path'
require 'espresso_path'
require 'espresso_path/geo_path'
include EspressoPath
RSpec.describe EspressoPath::GeoPath do

  it "login and get audiences" do

    geo_path = GeoPath.new
    geo_path.login
    puts geo_path.day_parts
  end
end
