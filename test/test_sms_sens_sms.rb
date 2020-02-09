require_relative 'test_helper'

class TestSmsSensSms < Minitest::Test
  def teardown
    return unless SensSms::Client.class_variable_defined? :@@access_key

    SensSms::Client.remove_class_variable :@@access_key
    SensSms::Client.remove_class_variable :@@service_id
    SensSms::Client.remove_class_variable :@@secret_key
  end

  def test_send_sms_success
    SensSms::Client.configure do |config|
      config.access_key = ENV['NCLOUD_ACCESS_KEY']
      config.secret_key = ENV['NCLOUD_SECRET_KEY']
      config.service_id = ENV['NCLOUD_SERVICE_ID']
    end
    sens_sms = SensSms::Client.new
    assert(sens_sms.deliver(type: :sms,
                            from_number: ENV['FROM_NUMBER'],
                            to_numbers: ENV['TO_NUMBER'],
                            message: '키스의 고유 조건은 입술끼리 만나야 하고 특별한 기술은 필요치 않다.'))
  end

  def test_send_sms_fail
    SensSms::Client.configure do |config|
      config.access_key = 'no_access_key'
      config.secret_key = ENV['NCLOUD_SECRET_KEY']
      config.service_id = ENV['NCLOUD_SERVICE_ID']
    end
    sens_sms = SensSms::Client.new
    refute(sens_sms.deliver(type: :sms,
                            from_number: ENV['FROM_NUMBER'],
                            to_numbers: ENV['TO_NUMBER'],
                            message: '키스의 고유 조건은 입술끼리 만나야 하고 특별한 기술은 필요치 않다.'))
  end
end
