require "espresso_path/version"
require 'espresso_path/configuration'
require 'httparty'
require 'json'

module EspressoPath
  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  def self.login
    #uri = URI.parse(EspressoPath.configuration.base_url + "/login")
    uri = URI.parse("https://insights-api.geopath.org/login")

  puts uri
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    puts EspressoPath.configuration.user_name
    request = Net::HTTP::Post.new(uri.request_uri)
    request.set_form_data({ :username => EspressoPath.configuration.user_name, :password => EspressoPath.configuration.password })

    response = http.request(request)
    puts response.body
    puts "here"
    body = JSON.parse(response.body)

    EspressoPath.configuration.client_token = body["access_token"]

    EspressoPath.configuration.options = {
        headers: {
            "Authorization"=> "Bearer #{EspressoPath.configuration.client_token}"
        }
    }
  end
end
