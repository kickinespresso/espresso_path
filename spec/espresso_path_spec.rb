require "spec_helper"

RSpec.describe EspressoPath do

  #api { EspressoPath.new }


  it "has a version number" do
    expect(EspressoPath::VERSION).not_to be nil
  end



  it "login and set token" do
    EspressoPath.login

  end
end
