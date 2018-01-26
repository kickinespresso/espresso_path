require "espresso_path/version"
require 'espresso_path/configuration'
require 'httparty'
require 'json'
require 'espresso_path/client'

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

end
