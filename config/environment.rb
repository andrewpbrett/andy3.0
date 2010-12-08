# Load the rails application
require File.expand_path('../application', __FILE__)

ENV['PATH'] = "#{ENV['PATH']}:/usr/local/bin"

# Initialize the rails application
Andy30::Application.initialize!
