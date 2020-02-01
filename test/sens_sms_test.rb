require 'test_helper'

class SensSmsTest < Minitest::Test
  def test_validating_configure
    assert_raises do
      SensSms::Client.new
    end
  end

  def test_send_sms_success
    SensSms::Client.configure(access_key: ENV['access_key'],
                              secret_key: ENV['secret_key'],
                              service_id: ENV['service_id'])
    sens_sms = SensSms::Client.new
    assert(sens_sms.deliver(type: :sms,
                            from_number: ENV['from_number'],
                            to_numbers: ENV['to_number'],
                            message: '키스의 고유 조건은 입술끼리 만나야 하고 특별한 기술은 필요치 않다.'))
  end

  def test_send_sms_fail
    SensSms::Client.configure(access_key: 'no_access_key',
                              secret_key: ENV['secret_key'],
                              service_id: ENV['service_id'])
    sens_sms = SensSms::Client.new
    refute(sens_sms.deliver(type: :sms,
                            from_number: ENV['from_number'],
                            to_numbers: ENV['to_number'],
                            message: '키스의 고유 조건은 입술끼리 만나야 하고 특별한 기술은 필요치 않다.'))
  end

  def test_send_lms_success
    SensSms::Client.configure(access_key: ENV['access_key'],
                              secret_key: ENV['secret_key'],
                              service_id: ENV['service_id'])
    sens_sms = SensSms::Client.new
    assert(sens_sms.deliver(type: :lms,
                            from_number: ENV['from_number'],
                            to_numbers: ENV['to_number'],
                            subject: '펭귄',
                            message: '전 세계에 알려진 펭귄의 종류는 17종 혹은 18종이다. (쇠푸른펭귄과 흰날개펭귄이
                                      식별되는지 아닌지에 따라 달라진다.) 모든 펭귄 종의 고향이 남반구이기는 하지만,
                                      통념과 달리, 남극과 같이 추운 기후에서만 서식하지는 않는다. 실제로는 몇몇 종만이
                                      극지방에 산다. 3종은 열대 지방에 살며, 그 가운데 갈라파고스 제도에 사는 한 종은 먹이를
                                      찾다가 적도를 건너기도 한다. 가장 큰 종은 황제펭귄으로, 다 자라면 키가 약 1.1미터,
                                      무게가 약 35킬로그램 이상이다. 가장 작은 종은 쇠푸른펭귄으로, 키는 약 40센티미터에
                                      몸무게가 1킬로그램에 불과하다. 일반적으로 펭귄은 덩치가 클수록 열을 잘 보관해서
                                      추운 지방에 살고, 작은 펭귄들은 온대나 심지어 열대에서 발견된다.'))
  end

  def test_send_lms_fail
    SensSms::Client.configure(access_key: 'no_access_key',
                              secret_key: ENV['secret_key'],
                              service_id: ENV['service_id'])
    sens_sms = SensSms::Client.new
    refute(sens_sms.deliver(type: :lms,
                            from_number: ENV['from_number'],
                            to_numbers: ENV['to_number'],
                            subject: '펭귄',
                            message: '전 세계에 알려진 펭귄의 종류는 17종 혹은 18종이다. (쇠푸른펭귄과 흰날개펭귄이
                                      식별되는지 아닌지에 따라 달라진다.) 모든 펭귄 종의 고향이 남반구이기는 하지만,
                                      통념과 달리, 남극과 같이 추운 기후에서만 서식하지는 않는다. 실제로는 몇몇 종만이
                                      극지방에 산다. 3종은 열대 지방에 살며, 그 가운데 갈라파고스 제도에 사는 한 종은 먹이를
                                      찾다가 적도를 건너기도 한다. 가장 큰 종은 황제펭귄으로, 다 자라면 키가 약 1.1미터,
                                      무게가 약 35킬로그램 이상이다. 가장 작은 종은 쇠푸른펭귄으로, 키는 약 40센티미터에
                                      몸무게가 1킬로그램에 불과하다. 일반적으로 펭귄은 덩치가 클수록 열을 잘 보관해서
                                      추운 지방에 살고, 작은 펭귄들은 온대나 심지어 열대에서 발견된다.'))
  end
end
