require 'logger'
require 'httparty'
require 'json'

module EspressoPath
  class Client
    include HTTParty

    def initialize
      self.class.base_uri EspressoPath.configuration.base_url
      login(EspressoPath.configuration.user_name, EspressoPath.configuration.password)
    end

    def login(username, password)
      uri = URI.parse(EspressoPath.configuration.base_url + '/login')
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      request = Net::HTTP::Post.new(uri.request_uri)
      request.set_form_data(username: username, password: password)
      response = http.request(request)
      body = JSON.parse(response.body)
      @access_token = body['access_token']
      @options = {
        headers: {
          Authorization: "Bearer #{@access_token}"
        }
      }
    end

    def audience
      self.class.get('/audience', @options)
    end

    def day_parts
      self.class.get('/day-parts', @options)
    end

    def counties
      self.class.get('/counties', @options)
    end

    def custom_demos
      self.class.get('/custom-demos', @options)
    end

    def media_types
      self.class.get('/media-types', @options)
    end

    def operators
      self.class.get('/operators', @options)
    end

    def plants
      self.class.get('/plants', @options)
    end

    def markets
      self.class.get('/markets', @options)
    end

    def market(market)
      self.class.get("/markets/#{market}", @options)
    end

    def panels
      self.class.get('/panels', @options)
    end

    def demo_categories
      self.class.get('/demos/categories', @options)
    end

    def states
      self.class.get('/states', @options)
    end
  end
end