require "spec_helper"

RSpec.describe EspressoPath do

  #api { EspressoPath.new }


  it "has a version number" do
    expect(EspressoPath::VERSION).not_to be nil
  end



  it "login and set token" do
    EspressoPath.login

  end

  # it "login and set token geo_path" do
  #   geo_path = EspressoPath::GeoPath.new
  #   geo_path.login
  #
  # end
end
