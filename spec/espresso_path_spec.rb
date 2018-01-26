require "spec_helper"

RSpec.describe EspressoPath do

  it "has a version number" do
    expect(EspressoPath::VERSION).not_to be nil
  end


  it "has a configuration attribute of user_name" do
    expect(EspressoPath.configuration.user_name).not_to be nil
  end
end
