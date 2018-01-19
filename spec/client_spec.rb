require "spec_helper"
require 'espresso_path'
require 'espresso_path/client'
include EspressoPath
RSpec.describe EspressoPath::Client do


  let(:client) { Client.new }

  it "gets day_parts" do
    client.day_parts
  end


end
