$heroku = ENV['USER'] ? !! ENV['USER'].match(/^repo\d+/) : ENV.any?{|key, _| key.match(/^HEROKU_/)}

source "http://rubygems.org"

gem "rails", "3.0.0"

gem "bson_ext",     "1.0.4"
gem "mongoid",      "2.0.0.beta.18"
gem "haml",         "3.0.18"
gem "sass",         "3.1.0.alpha.4"

unless $heroku
  gem "ruby-debug19", "0.11.6"
  
  group :development, :test do
    gem "jquery-rails",         "0.1.3"
    gem "rails_code_qa",        "0.4.1"
    gem "factory_girl_rails",   "1.0"
    gem "shoulda",              "2.11.3"
    gem "timecop",              "0.3.5"
  end
end
