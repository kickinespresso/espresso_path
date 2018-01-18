require "bundler/setup"
require "espresso_path"
require 'dotenv'

Dotenv.load

RSpec.configure do |config|


  config.before(:all) do
    EspressoPath.configure do |config|
      config.user_name = ENV['ESPRESSO_PATH_USER_NAME']
      config.password = ENV['ESPRESSO_PATH_PASSWORD']
      config.client_token = ENV['ESPRESSO_PATH_CLIENT_TOKEN']
    end
  end
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
