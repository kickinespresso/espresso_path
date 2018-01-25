require 'logger'
require 'httparty'
require 'json'

module EspressoPath
  ##
  # This class is the base client for the API
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
        },

      }
    end

    def map_services(type, level, ids, options = @options)
      options[:query] = { ids: ids}
      puts options.inspect
      self.class.get("/mapservices/#{type}/#{level}", @options)
    end

    def audience
      self.class.get('/audience', @options)
    end

    def census_tracts
      self.class.get('/census-tracts', @options)
    end

    def counties
      self.class.get('/counties', @options)
    end

    def custom_demos
      self.class.get('/custom-demos', @options)
    end

    def custom_markets
      self.class.get('/custom-markets', @options)
    end

    def day_parts
      self.class.get('/day-parts', @options)
    end

    def day_part(id)
      self.class.get("/day-parts/#{id}", @options)
    end

    def demos
      self.class.get('/demos/categories', @options)
    end

    def demo_subcategories(id)
      self.class.get("/demos/demo_subcategories/#{id}/demo", @options)
    end

    def market(market)
      self.class.get("/markets/#{market}", @options)
    end

    def markets
      self.class.get('/markets', @options)
    end

    # Get all the MediaTypes
    def media_types
      self.class.get('/media-types', @options)
    end

    # Get the MediaType referenced by the ID
    # # ==== Attributes
    #
    # * +id+ - The id of the object you wish to retrieve.
    def media_type(id)
      self.class.get("/media-types/#{id}", @options)
    end

    def operators
      self.class.get('/operators', @options)
    end

    def panel_sets
      self.class.get('/panel-sets', @options)
    end

    # Get all the panels
    def panels
      self.class.get('/panels', @options)
    end

    def panel(id)
      self.class.get("/panels/#{id}", @options)
    end

    def panels_nearby
      self.class.get('/panels/nearby', @options)
    end

    def plants
      self.class.get('/plants', @options)
    end

    def plant(id)
      self.class.get("/plants/#{id}", @options)
    end

    def states
      self.class.get('/states', @options)
    end
  end
end