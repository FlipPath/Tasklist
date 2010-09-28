ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'redgreen'
require 'shoulda/active_record'

class ActiveSupport::TestCase
end
