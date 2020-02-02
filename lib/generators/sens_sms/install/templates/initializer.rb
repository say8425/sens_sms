require 'sens_sms'

SensSms::Client.configure do |config|
  config.access_key = ENV['sens_sms_access_key']
  config.secret_key = ENV['sens_sms_secret_key']
  config.service_id = ENV['sens_sms_service_id']
end
