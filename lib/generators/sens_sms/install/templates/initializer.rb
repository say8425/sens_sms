require 'sens_sms'

SensSms::Client.configure do |config|
  config.access_key = ENV['NCLOUD_ACCESS_KEY']
  config.secret_key = ENV['NCLOUD_SECRET_KEY']
  config.service_id = ENV['NCLOUD_SERVICE_ID']
end
