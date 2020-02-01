require 'sens_sms'
SensSms::Client.configure(access_key: ENV['sens_sms_access_key'],
                          secret_key: ENV['sens_sms_secret_key'],
                          service_id: ENV['sens_sms_service_id'])
