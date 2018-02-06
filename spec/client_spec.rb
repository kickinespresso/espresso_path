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

  it "gets demographics" do
    response = client.demos
    expect(response).to be_success
  end

  it "gets demographis subcategories" do
    response = client.demo_subcategories('6b4aa721-b23e-4f05-b846-c7e850355636')
    expect(response).to be_success
  end

  it "gets panels by markets" do
    response = client.panels({market_ids: ['e92ee22c-4889-497f-a773-e01d555fdf34']})
    expect(response).to be_success

    response = client.panels({market_ids: ['e92ee22c-4889-497f-a773-e01d555fdf34', '6eee9ded-6a91-457f-94fb-b1ac45bf2737']})
    expect(response).to be_success
  end


  it "gets panels by markets tx" do
    response = client.panels({market_ids: ['5f0795d2-abaa-4550-9d21-d8e982864286']})
    puts response.inspect
    expect(response).to be_success

    # response = client.panels({market_ids: ['e92ee22c-4889-497f-a773-e01d555fdf34', '6eee9ded-6a91-457f-94fb-b1ac45bf2737']})
    # expect(response).to be_success
  end

  it "gets panels by counties" do
    response = client.panels({counties: ['36061']})
    expect(response).to be_success

    response = client.panels({counties: ['36061', '36005']})
    expect(response).to be_success
  end


  it "gets panels by states" do
    response = client.panels({states: ['34']})
    expect(response).to be_success

    response = client.panels({states: ['34', '36']})
    expect(response).to be_success
  end


  it "gets markets" do
    response = client.markets
    expect(response).to be_success

  end

  it "gets operators" do
    response = client.operators
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
