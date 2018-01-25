require "spec_helper"
require 'espresso_path'
require 'espresso_path/client'
include EspressoPath

RSpec.describe EspressoPath::Client do

  let(:client) { Client.new }

  it "gets day_parts" do
    client.day_parts
  end

  it "gets panels" do
    client.panels
  end

  it "gets markets" do
    client.panels
  end

  it "gets operators" do
    client.panels
  end

end
