require 'logger'
module EspressoPath
  class Configuration
    attr_accessor :user_name, :password, :client_token, :base_url, :options

    def initialize
      @user_name = nil
      @password = nil
      @client_token = nil
      @base_url = 'https://insights-api.geopath.org'
      @options = nil
    end
  end
end