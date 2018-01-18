EspressoPath.configure do |config|
  # defaults to ENV['ESPRESSO_PATH_USER_NAME']
  config.user_name = ENV['ESPRESSO_PATH_USER_NAME']
  #config.user_name = ''

  # Defaults to ENV['ESPRESSO_PATH_PASSWORD']
  #config.password  = ''
  config.password = ENV['ESPRESSO_PATH_PASSWORD']

  # Defaults to ENV['ESPRESSO_PATH_CLIENT_TOKEN']
  #config.client_token = ''
  config.client_token = ENV['ESPRESSO_PATH_CLIENT_TOKEN']

end

#Login?
EspressoPath::GeoPath.login