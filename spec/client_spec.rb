require "spec_helper"
require 'espresso_path'
require 'espresso_path/client'
include EspressoPath

RSpec.describe EspressoPath::Client do

  let(:client) { Client.new }


  it "gets map services" do
    response = client.map_services("DMA", 2, ['123', '435'])
    #puts response
    expect(response).to be_success


  end

  it "gets day_parts" do
    response = client.day_parts
    expect(response).to be_success

  end

  it "gets panels" do
    response = client.panels
    expect(response).to be_success

  end

  it "gets markets" do
    response = client.panels
    expect(response).to be_success

  end

  it "gets operators" do
    response = client.panels
    expect(response).to be_success

  end

  it "creates custom demo" do
    response = client.create_custom_demo("a test demo2", "user", { age_min: 18, age_max: 55})
    expect(response).to be_success
  end

  #
  # it "updates custom demo" do
  #   response = client.update_custom_demo()
  #   expect(response).to be_success
  # end


end
