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
        }
      }
    end

    def map_services(type, level, ids, options = @options)
      options[:query] = { ids: ids }
      self.class.get("/mapservices/#{type}/#{level}", @options)
    end

    # Get Audience
    #
    # # ==== Attributes
    # * +daypart_ids+ - REQUIRED - Comma-separated list of daypart IDs.
    # * +demo_ids+ - Optional - Comma-separated list of demo IDs. Either this or custom_demo_ids must be provided.
    # * +custom_demo_ids+ - Optional - Comma-separated list of custom demo IDs. Either this or demo_ids must be provided.
    # * +panel_ids+ - REQUIRED - Comma-separated list of panel IDs.
    # * +market_id+ - REQUIRED - Market ID to get information for.
    # * +population_base+ - REQUIRED - Base population.
    def audience(daypart_ids, panel_ids, market_id, population_base, opts ={})
      options = @options
      options[:query] = { daypart_ids: daypart_ids, panel_ids: panel_ids, market_id: market_id,
                          population_base: population_base }.merge(opts)
      self.class.get('/audience', options)
    end

    # Get Home Audience
    #
    # # ==== Attributes
    # * +daypart_id+ - REQUIRED - Daypart ID to look for.
    # * +demo_id+ - Optional - Comma-separated list of demo IDs. Either this or custom_demo_ids must be provided.
    # * +custom_demo_id+ - Optional - Comma-separated list of custom demo IDs. Either this or demo_ids must be provided.
    # * +panel_ids+ - REQUIRED - Comma-separated list of panel IDs.
    # * +market_id+ - REQUIRED - Market ID to get information for.
    # * +population_base+ - REQUIRED - Base population.
    # * +reporting_level+ - REQUIRED - Geo level to get homes for.
    def audience_home(daypart_id, panel_ids, market_id, population_base, reporting_level, opts ={})
      options = @options
      options[:query] = { daypart_id: daypart_id, panel_ids: panel_ids,
                          market_id: market_id, reporting_level: reporting_level,
                          population_base: population_base }.merge(opts)
      self.class.get('/audience/homes', options)
    end

    # Gets all Census Tracts
    def census_tracts
      self.class.get('/census-tracts', @options)
    end

    # Gets specified Census Tract
    # # ==== Attributes
    #
    # * +id+ - Required - Census TractID
    def census_tract(id)
      self.class.get("/census-tracts/#{id}", @options)
    end

    def counties
      self.class.get('/counties', @options)
    end

    def custom_demos
      self.class.get('/custom-demos', @options)
    end

    def custom_demo(id)
      self.class.get("/custom-demos/#{id}", @options)
    end

    # Create a Custom Demographic
    # # ==== Attributes
    #
    # * +name+ - Required - The name of demographic
    # * +age_min+ - Optional - The minimum age in the custom demo
    # * +age_max+ - Optional - The maximum age in the custom demo
    # * +hhinc_min+ - Optional - The minimum household income in the custom demo
    # * +hhinc_max+ - Optional - The maximum household income in the custom demo
    # * +races+ - Optional - The races included in the custom demo. Supported values are white, black, amerindian, asian, pacific, other
    # * +sex+ - Optional - The sex in the custom demo
    # * +employed+ - Optional - The employment status in the custom demo
    # * +audience+ - Required - Who can use this custom demo
    def create_custom_demo(name, audience = 'company', opts = {})
      options = @options
      options[:query] = { name: name, audience: audience }.merge(opts)
      self.class.post('/custom-demos', options)
    end

    # Update a Custom Demographic
    # # ==== Attributes
    #
    # * +id+ - Required - Custom Demographic ID
    # * +name+ - Optional - The name of demographic
    # * +age_min+ - Optional - The minimum age in the custom demo
    # * +age_max+ - Optional - The maximum age in the custom demo
    # * +hhinc_min+ - Optional - The minimum household income in the custom demo
    # * +hhinc_max+ - Optional - The maximum household income in the custom demo
    # * +races+ - Optional - The races included in the custom demo. Supported values are white, black, amerindian, asian, pacific, other
    # * +sex+ - Optional - The sex in the custom demo
    # * +employed+ - Optional - The employment status in the custom demo
    # * +audience+ - Optional - Who can use this custom demo
    def update_custom_demo(id, opts = {})
      options = @options
      options[:query] = opts
      self.class.put("/custom-demos/#{id}", options)
    end

    # Delete a Custom Demographic
    # # ==== Attributes
    #
    # * +id+ - Required - Custom Demographic ID
    def delete_custom_demo(id)
      self.class.delete("/custom-demos/#{id}", @options)
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