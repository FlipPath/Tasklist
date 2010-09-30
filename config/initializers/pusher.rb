if Rails.env == "development"
  begin
    config = YAML.load(File.open(File.join(Rails.root, "config", "pusher_development.yml")))
  rescue Exception => e
    puts "Unable to load Pusher development config"
    puts "reason: #{e.message}\n\n"
    exit
  end
elsif Rails.env == "production"
  begin
    config = {
      "app_id" => ENV["PUSHER_APP_ID"],
      "key"    => ENV["PUSHER_KEY"],
      "secret" => ENV["PUSHER_SECRET"]
    }
  rescue Exception => e
    puts "Unable to load Pusher production config"
    puts "Make sure ENV vars PUSHER_APP_ID, PUSHER_KEY and PUSHER_SECRET are set"
    puts "reason: #{e.message}\n\n"
    exit
  end
end

unless Rails.env == "test"
  Pusher.app_id = config["app_id"]
  Pusher.key    = config["key"]
  Pusher.secret = config["secret"]
end