# Load the rails application
require File.expand_path('../application', __FILE__)

ENV['PATH'] = "#{ENV['PATH']}:/usr/local/bin"
ENV['LD_LIBRARY_PATH'] = "#{ENV['LD_LIBRARY_PATH']}:/usr/local/lib"

# Initialize the rails application
Andy30::Application.initialize!
