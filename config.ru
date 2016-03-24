# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment', __FILE__)
config.assets.initialize_on_precompile = false
run Rails.application
