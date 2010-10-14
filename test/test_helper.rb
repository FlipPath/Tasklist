ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  setup do
    Pusher::Channel.any_instance.stubs(:trigger_async).returns(true)
    Pusher.app_id = '20'
    Pusher.key    = '12345678900000001'
    Pusher.secret = '12345678900000001'
    Pusher.host   = 'api.pusherapp.com'
    Pusher.port   = 80
  end
end
