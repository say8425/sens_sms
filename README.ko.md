# Ncloud Sens SMS Gem

[![gem version](https://img.shields.io/gem/v/sens_sms?color=cc342d&logo=ruby&logoColor=cc342d)](https://rubygems.org/gems/sens_sms)
[![GitHub Actions Test](https://github.com/say8425/sens_sms/workflows/Test/badge.svg)](https://github.com/say8425/sens_sms/actions?query=workflow%3ATest)
[![GitHub Actions Release](https://github.com/say8425/sens_sms/workflows/Release/badge.svg)](https://github.com/say8425/sens_sms/actions?query=workflow%3ARelease)
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/say8425/sens_sms/blob/master/LICENSE)

[Ncloud Sens](https://www.ncloud.com/product/applicationService/sens) SMS를 Ruby에서 보내세요.

If you want to read English document, then click [here](https://github.com/say8425/sens_sms/blob/master/README.en.md).

## Installation

### Rails

Application's Gemfile에 아래 줄을 추가하세요:

```ruby
gem 'sens_sms'
```

그 다음 아래 명령을 실행하세요:

```shell script
$ bundle
```

마지막으로 generator을 실행하세요:

```shell script
$ rails generate sens_sms:install
```

여기까지 하셨으면, sens_sms를 설정할 수 있는 `YOUR_PROJECT/config/initializers/sens_sms.rb` 파일이 추가된 것을 확인하실 수 있습니다.

```ruby
require 'sens_sms'

SensSms::Client.configure do |config|
  config.access_key = ENV['NCLOUD_ACCESS_KEY']
  config.secret_key = ENV['NCLOUD_SECRET_KEY']
  config.service_id = ENV['NCLOUD_SERVICE_ID']
end
```

이 파일에서 Ncloud access key를 직접 설정 할 수 있습니다. 하지만 환경변수를 통해 설정하실 것을 권장합니다.
Ncloud access key 를 발급하는 방법은 [여기](https://docs.ncloud.com/ko/sens/sens-1-2.html)에서 확인 하실 수 있습니다.

### Sinatra or Plain ol' Ruby

gem을 설치하세요:

```shell script
$ gem install sens_sms
```

rails generator 가 생성해준 설정 파일 처럼, `require 'sens_sms'` 과 `SensSms::Client.configure` block 을 호출해서 access keys를 세팅하세요.

## Usage

```ruby
# SMS
SensSms::Client.new
               .deliver(type: :sms,
                        from_number: '01012345678',
                        to_numbers: '01098765432',
                        message: '전 세계에 알려진 펭귄의 종류는 17종 혹은 18종이다.')
```

```ruby
# LMS
SensSms::Client.new
               .deliver(type: :lms,
                        from_number: '01012345678',
                        to_numbers: '01098765432',
                        title: '펭귄',
                        message: '전 세계에 알려진 펭귄의 종류는 17종 혹은 18종이다. (쇠푸른펭귄과 흰날개펭귄이
                                  식별되는지 아닌지에 따라 달라진다.) 모든 펭귄 종의 고향이 남반구이기는 하지만,
                                  통념과 달리, 남극과 같이 추운 기후에서만 서식하지는 않는다. 실제로는 몇몇 종만이
                                  극지방에 산다. 3종은 열대 지방에 살며, 그 가운데 갈라파고스 제도에 사는 한 종은 먹이를
                                  찾다가 적도를 건너기도 한다. 가장 큰 종은 황제펭귄으로, 다 자라면 키가 약 1.1미터,
                                  무게가 약 35킬로그램 이상이다. 가장 작은 종은 쇠푸른펭귄으로, 키는 약 40센티미터에
                                  몸무게가 1킬로그램에 불과하다. 일반적으로 펭귄은 덩치가 클수록 열을 잘 보관해서
                                  추운 지방에 살고, 작은 펭귄들은 온대나 심지어 열대에서 발견된다.')
```

`SensSms::Client.new.deliver` 함수를 아래 argument 들과 함께 위와 같이 호출하면 됩니다.

### From Number

`from_number` key로 [Ncloud SENS 콘솔에 등록된](https://docs.ncloud.com/ko/sens/sens-1-3.html#register-view-caller-id) 발신자 번호를 설정 할 수 있습니다.

### To Number

`to_numbers` key로 수신자 번호를 설정 할 수 있습니다. 
또한 `to_numbers` key는 Array type으로 여러 번호를 지정 할 수 있습니다. (예. `numbers: ['01012345678', '01009876543']` )

### Type

`type` key로 메시지 타입을 정할 수 있습니다.

#### [SMS Type](https://docs.ncloud.com/ko/sens/sens-1-3.html#send-sms-messages)

SMS는 제목을 쓸 수 없고, 80바이트로 제한되는 짧은 메시지를 보낼 수 있습니다.

#### [LMS Type](https://docs.ncloud.com/ko/sens/sens-1-3.html#send-lms-messages)

LMS는 제목을 쓸 수 있고, 2,000바이트로 제한되는 긴 메시지를 보낼 수 있습니다.

### Title

기본적으로 이 key는 optional이며, LMS 메시지에서 제목 용도로 쓰입니다. 물론 SMS 타입에서 쓸 수 있지만, 아무일도 생기지 않을 것입니다.

### Message

텍스트 메시지입니다.

## Contributing

버그 리포트와 풀리퀘스는 환영입니다.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
