# We need to load the exception class first
require File.expand_path('../../lib/exceptions', __FILE__)

# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
L2adena::Application.initialize!

# Load custom config file
require File.expand_path('../l2adena_config', __FILE__)
